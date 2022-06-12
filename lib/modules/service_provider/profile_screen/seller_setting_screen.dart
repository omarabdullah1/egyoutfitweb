import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:egyoutfitweb/modules/service_provider/profile_screen/seller_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';
import 'seller_promo_codes_screen.dart';

class SellerSettingScreen extends StatelessWidget {
  const SellerSettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = DashboardCubit.get(context).loginModel;
    DashboardCubit.get(context).image = null;
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) async {
        if (DashboardCubit.get(context).isEnglish) {
          await context.setLocale(const Locale('en'));
          await CacheHelper.saveData(
            key: 'lang',
            value: 'en',
          );
        } else {
          await context.setLocale(const Locale('ar'));
          await CacheHelper.saveData(
            key: 'lang',
            value: 'ar',
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 2.0,
                  color: Colors.black,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                LocaleKeys.sellerAcountScreen_account.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(model.image),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.sellerAcountScreen_welcome.tr() +
                                          '  ' +
                                          model.firstName +
                                          '!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                    ),
                                    Text(
                                      model.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50.0,
                              alignment: EasyLocalization.of(context)
                                          .locale
                                          .languageCode ==
                                      'ar'
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Text(
                                  LocaleKeys.sellerAcountScreen_myAccount.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const PromoCodesScreen(),
                                        );
                                      },
                                      child: Container(
                                        height: 30,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.local_offer_outlined,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              LocaleKeys
                                                  .sellerAcountScreen_promoCodes
                                                  .tr(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.navigate_next,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context, const SellerProfileScreen());
                                      },
                                      child: Container(
                                        height: 30,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.settings_outlined,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              LocaleKeys
                                                  .sellerAcountScreen_setting
                                                  .tr(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.navigate_next,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.contact_support_outlined,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              LocaleKeys
                                                  .sellerAcountScreen_contactUs
                                                  .tr(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.navigate_next,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.language_outlined,
                                        ),
                                        Text(
                                          LocaleKeys
                                              .userAccountScreen_changeLanguage
                                              .tr(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const Spacer(),
                                        const Text('AR',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Switch(
                                          value: DashboardCubit.get(context)
                                              .isEnglish,
                                          onChanged: (v) {
                                            DashboardCubit.get(context)
                                                .changeLanguageValue(v, context);
                                            log(EasyLocalization.of(context)
                                                .locale
                                                .languageCode);
                                          },
                                        ),
                                        const Text('EN',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: defaultButton(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 30.0,
                        radius: 14.0,
                        function: () {
                          DashboardCubit.get(context).currentIndex = 0;
                          DashboardCubit.get(context).signOut(context);
                        },
                        text: LocaleKeys.userAccountScreen_logout.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
