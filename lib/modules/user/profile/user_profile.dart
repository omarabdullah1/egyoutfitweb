import 'package:easy_localization/easy_localization.dart';
import 'package:egyoutfitweb/modules/user/profile/user_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';
import 'change_password_screen.dart';
import 'user_settings_screen.dart';

var one = GlobalKey();

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).loginModel;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) async {
        if (ShopCubit.get(context).isEnglish) {
          await context.setLocale(const Locale('en'));
        } else {
          await context.setLocale(const Locale('ar'));
        }
      },
      builder: (context, state) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (CacheHelper.getData(key: 'showCase') == null) {
        //     ShowCaseWidget.of(context).startShowCase([one]);
        //   }
        // });

        return  SafeArea(
            child: Center(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 2,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(14.0),
                //   border: Border.all(
                //     color: Colors.grey,
                //     width: 2.0,
                //   ),
                // ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  LocaleKeys.userAccountScreen_account.tr(),
                                  // 'Account',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              LocaleKeys.userAccountScreen_welcome.tr() +
                                  ' ' +
                                  (model.firstName ?? '') +
                                  '!',
                              style: const TextStyle(
                                  color: Colors.orange, fontSize: 20),
                            ),
                            Text(
                              model.email ?? '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[400],
                      // height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              LocaleKeys.userAccountScreen_myEgyOutFitStoreAccount
                                  .tr(),
                              style: const TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(context, const OrdersScreen());
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.shop,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  LocaleKeys.userAccountScreen_orders.tr(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.navigate_next,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[400],
                      // height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              LocaleKeys.userAccountScreen_mySettings.tr(),
                              style: const TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(context, const SettingsScreen());
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  LocaleKeys.userAccountScreen_details.tr(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.navigate_next,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDivider(),
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const ChangePasswordScreen());
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lock,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  LocaleKeys.userAccountScreen_changePassword
                                      .tr(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.navigate_next,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDivider(),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              alignment: AlignmentDirectional.centerStart,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.contact_support,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    LocaleKeys.sellerAcountScreen_contactUs.tr(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.navigate_next,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.language,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                LocaleKeys.userAccountScreen_changeLanguage.tr(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              const Spacer(),
                              const Text('AR',
                                  style: TextStyle(color: Colors.black)),
                              Switch(
                                value: ShopCubit.get(context).isEnglish,
                                onChanged: (v) {
                                  ShopCubit.get(context)
                                      .changeLanguageValue(v, context);
                                },
                              ),
                              const Text('EN',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                        child: SizedBox(
                      height: double.infinity,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: defaultButton(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 30.0,
                        radius: 14.0,
                        function: () {
                          ShopCubit.get(context).signOut(context);
                        },
                        text: LocaleKeys.userAccountScreen_logout.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}
