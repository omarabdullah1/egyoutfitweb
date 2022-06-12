import 'package:conditional_builder/conditional_builder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

var formKey = GlobalKey<FormState>();

var firstNameController = TextEditingController();

var secondNameController = TextEditingController();

var addressController = TextEditingController();

var phoneController = TextEditingController();

var emailController = TextEditingController();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void didChangeDependencies() {
    var model = ShopCubit.get(context).loginModel;
    EasyLocalization.of(context).locale.languageCode == 'en'
        ? ShopCubit.get(context).userRegisterDropdownValueEn = model.city
        : ShopCubit.get(context).userRegisterDropdownValueAr =
            ShopCubit.get(context)
                .itemsAr[ShopCubit.get(context).itemsEn.indexOf(model.city)];

    if (model != null) {
      firstNameController.text = model.firstName;
      secondNameController.text = model.secondName;
      addressController.text = model.address;
      phoneController.text = model.phone;
      emailController.text = model.email;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).loginModel != null,
            builder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is ShopLoadingUpdateUserState)
                              const LinearProgressIndicator(),
                            const CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person)),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: firstNameController,
                              type: TextInputType.name,
                              isValidate: true,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return LocaleKeys
                                      .userAccountScreen_firstNameMustNotBeEmpty
                                      .tr();
                                }

                                return null;
                              },
                              label: LocaleKeys.userAccountScreen_firstName.tr(),
                              prefix: Icons.person,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: secondNameController,
                              type: TextInputType.name,
                              isValidate: true,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return LocaleKeys
                                      .userAccountScreen_lastNameMustNotBeEmpty
                                      .tr();
                                }

                                return null;
                              },
                              label: LocaleKeys.userAccountScreen_lastName.tr(),
                              prefix: Icons.person,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: addressController,
                              type: TextInputType.text,
                              isValidate: true,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return LocaleKeys
                                      .userCartScreen_addressMustNotBeEmptyValidation
                                      .tr();
                                }

                                return null;
                              },
                              label: LocaleKeys.userAccountScreen_address.tr(),
                              prefix: Icons.home,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.text,
                              isValidate: true,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return LocaleKeys
                                      .signUpScreen_pleaseEnterYourEmailAddress
                                      .tr();
                                }

                                return null;
                              },
                              label: LocaleKeys.signUpScreen_emailAddress.tr(),
                              prefix: Icons.email,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              isValidate: true,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return LocaleKeys.userCartScreen_phoneMustNotBeEmpty
                                      .tr();
                                }

                                return null;
                              },
                              label: LocaleKeys.userAccountScreen_phone.tr(),
                              prefix: Icons.phone,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      const Icon(
                                        Icons.list,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          LocaleKeys.signUpScreen_select_City.tr(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: EasyLocalization.of(context)
                                              .locale
                                              .languageCode ==
                                          'en'
                                      ? ShopCubit.get(context)
                                          .itemsEn
                                          .map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList()
                                      : ShopCubit.get(context)
                                          .itemsAr
                                          .map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                  value: EasyLocalization.of(context)
                                              .locale
                                              .languageCode ==
                                          'en'
                                      ? ShopCubit.get(context)
                                          .userRegisterDropdownValueEn
                                      : ShopCubit.get(context)
                                          .userRegisterDropdownValueAr,
                                  onChanged: (value) {
                                    ShopCubit.get(context)
                                        .userChangeDropValue(value, context);
                                    // selectedValue = value as String;
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 20.0,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: 160,
                                  buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2.5,
                                      color: Colors.black26,
                                    ),
                                    color: Colors.white,
                                  ),
                                  itemHeight: 40,
                                  itemPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  dropdownMaxHeight: 200,
                                  dropdownWidth: 200,
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 6,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(0, 0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! UpdateStateLoadingShopState,
                              builder:(context)=> defaultButton(
                                height: 60.0,
                                radius: 14.0,
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    ShopCubit.get(context).updateUserData(
                                      nameFirst: firstNameController.text,
                                      nameSecond: secondNameController.text,
                                      phone: phoneController.text,
                                      address: addressController.text,
                                      context: context,
                                      uid: ShopCubit.get(context).loginModel.uId,
                                      email: emailController.text,
                                      city: EasyLocalization.of(context)
                                                  .locale
                                                  .languageCode ==
                                              'en'
                                          ? ShopCubit.get(context)
                                              .userRegisterDropdownValueEn
                                          : ShopCubit.get(context)
                                              .userRegisterDropdownValueAr,
                                    );
                                    ShopCubit.get(context).resetEmailAddress(
                                        newEmail: emailController.text,
                                        oldEmail:
                                            ShopCubit.get(context).loginModel.email,
                                        password: CacheHelper.getData(key: 'pass'),
                                      context: context,
                                    );
                                    showToast(text: 'Updated Successfully', state: ToastStates.success);
                                  }

                                },
                                text: LocaleKeys.userAccountScreen_update.tr(),
                              ),
                              fallback: (context)=> const Center(child: CircularProgressIndicator(),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
