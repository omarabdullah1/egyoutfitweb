import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egyoutfitweb/models/user/user_model.dart';
import 'package:egyoutfitweb/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login_screen.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  UserModel loginModel;

  bool isEnglish = CacheHelper.getData(key: 'lang') == 'en'? true : false;

  Future<void> userLogin({
    @required context,
    @required String email,
    @required String password,
  }) async {
    emit(ShopLoginLoadingState());
    await FirebaseFirestore.instance.disableNetwork();
    await FirebaseFirestore.instance.enableNetwork();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // await CacheHelper.saveData(key: 'UID', value: value.user?.uid);
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user.uid)
          .get()
          .then((value) async {
        if(value.data()['isEmailVerfied']) {
          loginModel = UserModel.fromJson(value.data());
          emit(ShopLoginSuccessState(loginModel));
        }else {
          signOut(context);
          emit(ShopLoginErrorState(('error.toString()')));
        }
      }).catchError((error) {
        log(error.toString());
        emit(ShopLoginErrorState((error.toString())));
      });
    }).catchError((error) {
      log(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  void signOut(context) {
    CacheHelper.removeData(
      key: 'token',
    ).then((value) {
      if (value) {
        emit(ShopLogoutState());
        navigateAndFinish(
          context,
          const LoginScreen(),
        );
      }
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  Future<void> resetPassword(email) async {
    emit(ResetPasswordLoadingState());
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((
        value) {
      showToast(text: 'The email has been sent', state: ToastStates.success);
      emit(ResetPasswordSuccessState());
    }).catchError((err) {
      log(err.toString());
      showToast(text: 'Error when sending Email', state: ToastStates.error);
      emit(ResetPasswordErrorState());
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }

  changeLanguageValue(v, context) async {
    isEnglish = v;
    log(isEnglish.toString());
    CacheHelper.saveData(key: 'lang', value: isEnglish);
    emit(AppChangeLanguageState());
  }
}
