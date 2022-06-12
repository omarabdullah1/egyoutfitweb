import 'dart:developer';
import 'dart:io';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  var formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();

  var secondNameController = TextEditingController();

  var addressController = TextEditingController();

  var organizationController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);

    log(DashboardCubit.get(context).loginModel.uId);
    log(DashboardCubit.get(context).loginModel.sat.toString());
    log(DashboardCubit.get(context).loginModel.sun.toString());
    log(DashboardCubit.get(context).loginModel.mon.toString());
    log(DashboardCubit.get(context).loginModel.tus.toString());
    log(DashboardCubit.get(context).loginModel.wed.toString());
    log(DashboardCubit.get(context).loginModel.thu.toString());
    log(DashboardCubit.get(context).loginModel.fri.toString());

    EasyLocalization.of(context).locale.languageCode == 'en'
        ? DashboardCubit.get(context).userRegisterDropdownValueEn =
            DashboardCubit.get(context).loginModel.city
        : DashboardCubit.get(context).userRegisterDropdownValueAr =
            DashboardCubit.get(context).cityItemsAr[DashboardCubit.get(context)
                .cityItemsEn
                .indexOf(DashboardCubit.get(context).loginModel.city)];
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (DashboardCubit.get(context).loginModel != null) {
          firstNameController.text =
              DashboardCubit.get(context).loginModel.firstName;
          secondNameController.text =
              DashboardCubit.get(context).loginModel.secondName;
          organizationController.text =
              DashboardCubit.get(context).loginModel.organization;
          phoneController.text = DashboardCubit.get(context).loginModel.phone;
          addressController.text =
              DashboardCubit.get(context).loginModel.address;
          emailController.text = DashboardCubit.get(context).loginModel.email;
        }
        return WillPopScope(
          onWillPop: () async {
            if (isDialOpen.value) {
              isDialOpen.value = false;
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_outlined)),
            ),
            body: ConditionalBuilder(
              condition: DashboardCubit.get(context).loginModel != null,
              builder: (context) => Center(
                child: Container(
                  width:
                  MediaQuery.of(context).size.width /
                      2,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is LoadingUploadImageState)
                                const LinearProgressIndicator(),
                              DashboardCubit.get(context).loginModel.image != null
                                  ? Stack(
                                      children: [
                                        DashboardCubit.get(context).image == null
                                            ? CircleAvatar(
                                                radius: 80.0,
                                                backgroundColor: Colors.grey,
                                                backgroundImage: NetworkImage(
                                                    DashboardCubit.get(context)
                                                        .loginModel
                                                        .image),
                                                child: const Icon(Icons.person),
                                              )
                                            : CircleAvatar(
                                                radius: 80.0,
                                                backgroundColor: Colors.grey,
                                                backgroundImage: Image.network(
                                                    DashboardCubit.get(context).image.path,
                                                ).image,
                                              ),
                                        Positioned(
                                          bottom: 2.0,
                                          right: 2.0,
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: SpeedDial(
                                              animatedIcon: AnimatedIcons.menu_close,
                                              openCloseDial: isDialOpen,
                                              backgroundColor: Colors.black,
                                              overlayColor: Colors.grey,
                                              overlayOpacity: 0.5,
                                              spacing: 15,
                                              spaceBetweenChildren: 15,
                                              closeManually: true,
                                              children: [
                                                SpeedDialChild(
                                                    child: const Icon(
                                                      Icons.image,
                                                    ),
                                                    label: LocaleKeys
                                                        .sellerAcountScreen_Photos
                                                        .tr(),
                                                    onTap: () {
                                                      DashboardCubit.get(context)
                                                          .getImageProfile(false);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const Icon(Icons.person),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: firstNameController,
                                type: TextInputType.name,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .sellerAcountScreen_nameMustNotBeEmpty
                                        .tr();
                                  }

                                  return null;
                                },
                                label: LocaleKeys.sellerAcountScreen_sellerFirstName
                                    .tr(),
                                prefix: Icons.person,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: secondNameController,
                                type: TextInputType.name,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .sellerAcountScreen_nameMustNotBeEmpty
                                        .tr();
                                  }

                                  return null;
                                },
                                label: LocaleKeys.sellerAcountScreen_sellerSecondName
                                    .tr(),
                                prefix: Icons.person,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: addressController,
                                type: TextInputType.text,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .sellerAcountScreen_addressMustNotBeEmpty
                                        .tr();
                                  }

                                  return null;
                                },
                                label:
                                    LocaleKeys.sellerAcountScreen_sellerAddress.tr(),
                                prefix: Icons.location_on_rounded,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.text,
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
                                controller: organizationController,
                                type: TextInputType.text,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .sellerAcountScreen_shopNameMustNotBeEmpty
                                        .tr();
                                  }

                                  return null;
                                },
                                label: LocaleKeys
                                    .sellerAcountScreen_sellerOrganization
                                    .tr(),
                                prefix: Icons.home_repair_service,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              defaultFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys
                                        .sellerAcountScreen_phoneMustNotBeEmpty
                                        .tr();
                                  }

                                  return null;
                                },
                                label: LocaleKeys.sellerAcountScreen_sellerPhone.tr(),
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
                                        ? DashboardCubit.get(context)
                                            .cityItemsEn
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
                                        : DashboardCubit.get(context)
                                            .cityItemsAr
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
                                        ? DashboardCubit.get(context)
                                            .userRegisterDropdownValueEn
                                        : DashboardCubit.get(context)
                                            .userRegisterDropdownValueAr,
                                    onChanged: (value) {
                                      DashboardCubit.get(context)
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            child: buildSizeCircle(
                                                size: 'SAT',
                                                state: DashboardCubit.get(context)
                                                    .isSaturday),
                                            onTap: () {
                                              DashboardCubit.get(context)
                                                  .changeDate('isSaturday');
                                            }),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                            child: buildSizeCircle(
                                                size: 'SUN',
                                                state: DashboardCubit.get(context)
                                                    .isSunday),
                                            onTap: () {
                                              DashboardCubit.get(context)
                                                  .changeDate('isSunday');
                                            }),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'MON',
                                              state: DashboardCubit.get(context)
                                                  .isMonday),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeDate('isMonday');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'TUS',
                                              state: DashboardCubit.get(context)
                                                  .isTuesday),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeDate('isTuesday');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'WED',
                                              state: DashboardCubit.get(context)
                                                  .isWednesday),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeDate('isWednesday');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'THU',
                                              state: DashboardCubit.get(context)
                                                  .isThursday),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeDate('isThursday');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'FRI',
                                              state: DashboardCubit.get(context)
                                                  .isFriday),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeDate('isFriday');
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ConditionalBuilder(
                                      condition: state
                                          is! UpdateLocationLoadingDashboardState,
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              14.0,
                                            ),
                                            color: Colors.black,
                                          ),
                                          height: 60.0,
                                          child: MaterialButton(
                                            onPressed: () async {
                                              await DashboardCubit.get(context)
                                                  .getGeoLocationPosition()
                                                  .then((value) async {
                                                var position = value;
                                                // var c = Coords(position.latitude,
                                                //     position.longitude);
                                                DashboardCubit.get(context)
                                                    .getAddressFromLatLong(position);
                                                log('Lat: ${position.latitude} , Long: ${position.longitude}');
                                                DashboardCubit.get(context)
                                                    .updateLocation(
                                                  uid: DashboardCubit.get(context)
                                                      .loginModel
                                                      .uId,
                                                  latitude: position.latitude,
                                                  longitude: position.longitude,
                                                  posStreet:
                                                      DashboardCubit.get(context)
                                                          .place
                                                          .street,
                                                );
                                              });
                                            },
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: ConditionalBuilder(
                                      condition: state
                                          is! UpdateStateLoadingDashboardState,
                                      builder:(context)=> defaultButton(
                                        height: 60.0,
                                        radius: 14.0,
                                        function: () {
                                          if (formKey.currentState.validate()) {
                                            if (DashboardCubit.get(context).image !=
                                                null) {
                                              DashboardCubit.get(context)
                                                  .uploadProfileImageToFireBase(
                                                uid: DashboardCubit.get(context)
                                                    .loginModel
                                                    .uId,
                                                fname: firstNameController.text,
                                                sname: secondNameController.text,
                                                phone: phoneController.text,
                                                organization:
                                                    organizationController.text,
                                                address: addressController.text,
                                                context: context,
                                                city: EasyLocalization.of(context)
                                                            .locale
                                                            .languageCode ==
                                                        'en'
                                                    ? DashboardCubit.get(context)
                                                        .userRegisterDropdownValueEn
                                                    : DashboardCubit.get(context)
                                                        .userRegisterDropdownValueAr,
                                                sat: DashboardCubit.get(context)
                                                    .isSaturday,
                                                sun: DashboardCubit.get(context)
                                                    .isSunday,
                                                mon: DashboardCubit.get(context)
                                                    .isMonday,
                                                tus: DashboardCubit.get(context)
                                                    .isTuesday,
                                                wed: DashboardCubit.get(context)
                                                    .isWednesday,
                                                thu: DashboardCubit.get(context)
                                                    .isThursday,
                                                fri: DashboardCubit.get(context)
                                                    .isFriday,
                                              );
                                              DashboardCubit.get(context)
                                                  .resetEmailAddress(
                                                oldEmail: DashboardCubit.get(context)
                                                    .loginModel
                                                    .email,
                                                newEmail: emailController.text,
                                                password:
                                                    CacheHelper.getData(key: 'pass'),
                                                context: context,
                                              );
                                              showToast(text: 'Updated Successfully', state: ToastStates.success);
                                            } else {
                                              DashboardCubit.get(context)
                                                  .updateSellerData(
                                                uid: DashboardCubit.get(context)
                                                    .loginModel
                                                    .uId,
                                                fname: firstNameController.text,
                                                sname: secondNameController.text,
                                                phone: phoneController.text,
                                                organization:
                                                    organizationController.text,
                                                city: EasyLocalization.of(context)
                                                            .locale
                                                            .languageCode ==
                                                        'en'
                                                    ? DashboardCubit.get(context)
                                                        .userRegisterDropdownValueEn
                                                    : DashboardCubit.get(context)
                                                        .userRegisterDropdownValueAr,
                                                address: addressController.text,
                                                image: DashboardCubit.get(context)
                                                    .firebaseImagesEdit,
                                                context: context,
                                                sat: DashboardCubit.get(context)
                                                    .isSaturday,
                                                sun: DashboardCubit.get(context)
                                                    .isSunday,
                                                mon: DashboardCubit.get(context)
                                                    .isMonday,
                                                tus: DashboardCubit.get(context)
                                                    .isTuesday,
                                                wed: DashboardCubit.get(context)
                                                    .isWednesday,
                                                thu: DashboardCubit.get(context)
                                                    .isThursday,
                                                fri: DashboardCubit.get(context)
                                                    .isFriday,
                                              );
                                              DashboardCubit.get(context)
                                                  .resetEmailAddress(
                                                oldEmail: DashboardCubit.get(context)
                                                    .loginModel
                                                    .email,
                                                newEmail: emailController.text,
                                                password:
                                                CacheHelper.getData(key: 'pass'),
                                                context: context,
                                              );
                                              showToast(text: 'Updated Successfully', state: ToastStates.success);
                                            }
                                          }
                                        },
                                        text: LocaleKeys.sellerAcountScreen_Update.tr(),
                                      ),
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
        );
      },
    );
  }
}
