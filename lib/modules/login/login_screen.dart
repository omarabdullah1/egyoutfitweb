import 'dart:developer';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/dashboard_layout/dashboard_layout.dart';
import '../../layout/shop_app/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../translations/locale_keys.g.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) async {
          if (state is ShopLoginSuccessState) {
            log(state.loginModel.firstName);
            log(state.loginModel.uId);
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.uId,
            ).then((value) {
              CacheHelper.saveData(key: 'user', value: emailController.text);
              CacheHelper.saveData(key: 'pass', value: passwordController.text);
              token = state.loginModel.uId;
              showToast(
                  text: LocaleKeys.alerts_loginSuccessfully.tr(),
                  state: ToastStates.success);
              state.loginModel.isSeller
                  ? navigateAndFinish(
                context,
                const DashboardLayout(),
              )
                  : navigateAndFinish(
                context,
                const ShopLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Center(
                          child: Image(
                            image: AssetImage(
                              'assets/images/logo black.png',
                            ),
                            width: 125,
                            height: 125,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Text(
                                LocaleKeys.loginScreen_loginToYourAccount.tr(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                isValidate: true,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .loginScreen_pleaseEnterYourEmailAddress
                                        .tr();
                                  }
                                },
                                label: LocaleKeys.loginScreen_emailAddress.tr(),
                                prefix: Icons.email_outlined,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                suffix: ShopLoginCubit.get(context).suffix,
                                isValidate: true,
                                onSubmit: (value) {
                                  if (formKey.currentState.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
                                    );
                                  }
                                },
                                isPassword: ShopLoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  ShopLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .loginScreen_pleaseEnterYourPassword
                                        .tr();
                                  }
                                },
                                label: LocaleKeys.loginScreen_password.tr(),
                                prefix: Icons.lock_outline,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  onPressed: () {
                                    navigateTo(
                                        context, const ForgetPasswordScreen());
                                  },
                                  child: Text(
                                    LocaleKeys.loginScreen_forgetPassword.tr(),
                                    style:
                                        const TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              state is ShopLoginErrorState
                                  ? Text(
                                      LocaleKeys
                                          .loginScreen_invalidUsernameOrPassword
                                          .tr(),
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Colors.red),
                                    )
                                  : const SizedBox(
                                      height: 1.0,
                                    ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ConditionalBuilder(
                                condition: state is! ShopLoginLoadingState,
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                                builder: (context) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 70),
                                  child: MaterialButton(
                                    height: 55,
                                    minWidth: 340,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          context: context,
                                        );
                                      }
                                      // Navigator.push(context,MaterialPageRoute(builder: (context)=> RegisterScreen()));
                                    },
                                    child: Text(
                                      LocaleKeys.loginScreen_login.tr().toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
