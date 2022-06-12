import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../translations/locale_keys.g.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.forgetPasswordScreen_pleaseEnterEmail.tr(),
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
                              height: 10.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ResetPasswordLoadingState,
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                              builder: (context) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: MaterialButton(
                                  height: 55,
                                  minWidth: 340,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      ShopLoginCubit.get(context)
                                          .resetPassword(emailController.text);
                                    }
                                    // Navigator.push(context,MaterialPageRoute(builder: (context)=> RegisterScreen()));
                                  },
                                  child: Text(
                                    LocaleKeys.forgetPasswordScreen_resetPassword.tr(),
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
                          ],
                        ),
                      ),
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
