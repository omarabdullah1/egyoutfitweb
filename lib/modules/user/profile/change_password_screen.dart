import 'dart:developer';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var formKey = GlobalKey<FormState>();

  var newPasswordController = TextEditingController();

  var newPasswordConfirmController = TextEditingController();

  var oldPasswordController = TextEditingController();
  var mOldPass = '';

  @override
  Future<void> didChangeDependencies() async {
    mOldPass = await CacheHelper.getData(key: 'pass');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultFormField(
                              controller: oldPasswordController,
                              type: TextInputType.visiblePassword,
                              label: LocaleKeys.alerts_oldPassword.tr(),
                              prefix: Icons.lock,
                              suffix: ShopCubit.get(context).suffix1,
                              isPassword: ShopCubit.get(context).isPassword1,
                              suffixPressed: () {
                                ShopCubit.get(context).changePasswordVisibility1();
                              },
                              isValidate: true,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return LocaleKeys.alerts_pleaseEnterOldPassword
                                      .tr();
                                }
                              },
                            ),
                            const SizedBox(height: 20.0),
                            defaultFormField(
                              controller: newPasswordController,
                              type: TextInputType.visiblePassword,
                              label: LocaleKeys.alerts_newPassword.tr(),
                              prefix: Icons.lock,
                              suffix: ShopCubit.get(context).suffix2,
                              isPassword: ShopCubit.get(context).isPassword2,
                              suffixPressed: () {
                                ShopCubit.get(context).changePasswordVisibility2();
                              },
                              isValidate: true,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return LocaleKeys.alerts_pleasEenterNewPassword
                                      .tr();
                                }
                              },
                            ),
                            const SizedBox(height: 20.0),
                            defaultFormField(
                              controller: newPasswordConfirmController,
                              type: TextInputType.visiblePassword,
                              label: LocaleKeys.alerts_newPasswordConfirm.tr(),
                              prefix: Icons.lock,
                              suffix: ShopCubit.get(context).suffix3,
                              isPassword: ShopCubit.get(context).isPassword3,
                              suffixPressed: () {
                                ShopCubit.get(context).changePasswordVisibility3();
                              },
                              isValidate: true,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return LocaleKeys
                                      .alerts_pleasEenterNewPasswordConfirm
                                      .tr();
                                } else if (value != newPasswordController.text) {
                                  return LocaleKeys.signUpScreen_passwordNotMatching
                                      .tr();
                                }
                              },
                            ),
                            const SizedBox(height: 20.0),
                            ShopCubit.get(context).isError
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      LocaleKeys.signUpScreen_passwordNotMatching
                                          .tr(),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 20.0),
                            ConditionalBuilder(
                              condition: state is! UpdateStateLoadingShopState,
                              builder: (context) => defaultButton(
                                function: () async {
                                  if (formKey.currentState.validate() &&
                                      oldPasswordController.text == mOldPass) {
                                    ShopCubit.get(context).changeIsError(false);
                                    log(newPasswordConfirmController.text);
                                    await ShopCubit.get(context).changeUserPassword(
                                        newPasswordConfirmController.text, context);
                                  } else {
                                    ShopCubit.get(context).changeIsError(true);
                                    log('error');
                                  }
                                },
                                text: 'Update',
                                height: 50.0,
                                width: 300,
                                isUpperCase: true,
                                radius: 14.0,
                              ),
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                            ),
                            state is UpdateStateErrorShopState
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      LocaleKeys.alerts_errorInRegistration.tr(),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//                           ),
//                           defaultFormField(
//                             controller: secondNameController,
//                             type: TextInputType.text,
//                             label: 'Second Name',
//                             prefix: Icons.person,
//                           ),
//                           defaultFormField(
//                             controller: addressController,
//                             type: TextInputType.text,
//                             label: 'Address',
//                             prefix: Icons.location_on,
//                           ),
//                           defaultFormField(
//                             controller: phoneController,
//                             type: TextInputType.number,
//                             label: 'Phone',
//                             prefix: Icons.phone,
//                           ),
//                           defaultButton(
//                               function: () async {
//                                 await ShopCubit.get(context).updateUser(
//                                     firstNameController.text,
//                                     secondNameController.text,
//                                     addressController.text,
//                                     phoneController.text,
//                                     context);
//                               },
//                               text: 'Update',
//                               height: 50.0,
//                               width: 300,
//                               isUpperCase: true),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//         return Scaffold(
//           appBar: AppBar(),
//           body: Center(
//             child: Text('Please login to see your profile'),
//           ),
//         );
//       },
//     );
//   }
// }
