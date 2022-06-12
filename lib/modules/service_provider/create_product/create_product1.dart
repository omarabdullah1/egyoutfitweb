import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';
import 'create_product2.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var caroController = CarouselController();
    // var categoryController = TextEditingController();
    var nameController = TextEditingController();
    String description;
    bool isDescripted = false;

    return BlocProvider(
      create: (BuildContext context) => DashboardCubit(),
      child: BlocConsumer<DashboardCubit, DashboardStates>(
        listener: (context, state) {
          // if (state is CreateProductSuccessState) {
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 80.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border:
                                Border.all(width: 2.0, color: Colors.black)),
                        child: CarouselSlider(
                          items: DashboardCubit.get(context).listImage.isEmpty
                              ? const [Icon(Icons.image)]
                              : DashboardCubit.get(context)
                                  .listImage
                                  .map((e) => Image.network(e.path))
                                  .toList(),
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              DashboardCubit.get(context).changeCarousel(index);
                            },
                            aspectRatio: 1.0,
                            height: 200,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          ),
                          carouselController: caroController,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DotsIndicator(
                        dotsCount:
                            DashboardCubit.get(context).listImage.isNotEmpty
                                ? DashboardCubit.get(context).listImage.length
                                : 1,
                        position:
                            DashboardCubit.get(context).caroIndex.toDouble(),
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // DashboardCubit.get(context).listImage.isNotEmpty
                      //     ? Padding(
                      //         padding: EdgeInsets.only(
                      //             bottom: 15.0,
                      //             right: MediaQuery.of(context).size.width / 9,
                      //             left: MediaQuery.of(context).size.width / 9),
                      //         child: SizedBox(
                      //           height: 100.0,
                      //           child: ListView.separated(
                      //             scrollDirection: Axis.horizontal,
                      //             // shrinkWrap: true,
                      //             itemBuilder:
                      //                 (BuildContext context, int index) {
                      //               return Semantics(
                      //                 child: Stack(
                      //                   children: [
                      //                     Image.file(File(DashboardCubit.get(context).listImage[index].path)),
                      //                     Positioned(
                      //                       top: 0.0,
                      //                       right: -15.0,
                      //                       child: SizedBox(
                      //                         height: 20.0,
                      //                         child: FloatingActionButton(
                      //                           child: const Icon(
                      //                             Icons.close,
                      //                             color: Colors.black,
                      //                             size: 13.0,
                      //                           ),
                      //                           onPressed: () {
                      //                             DashboardCubit.get(context)
                      //                                 .removeImageFromList(
                      //                                     index);
                      //                           },
                      //                           backgroundColor: Colors.white,
                      //                         ),
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //             separatorBuilder:
                      //                 (BuildContext context, int index) {
                      //               return const SizedBox(
                      //                 width: 10.0,
                      //               );
                      //             },
                      //             itemCount: DashboardCubit.get(context)
                      //                 .listImage
                      //                 .length,
                      //           ),
                      //         ),
                      //       )
                      //     : const SizedBox(
                      //         height: 1,
                      //       ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultButton(
                              function: () {
                                DashboardCubit.get(context)
                                    .getMultiImage(false);
                                DashboardCubit.get(context)
                                    .listImage.forEach((element) {log(element.name);});
                              },
                              text: LocaleKeys.sellerAcountScreen_Photos.tr(),
                              background: Colors.black,
                              isIcon: true,
                              icon: Icons.image,
                              width: MediaQuery.of(context).size.width / 2.6,
                              height: 50.0,
                              radius: 25.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical:
                                MediaQuery.of(context).size.height / 45.0),
                        child: Form(
                          key: formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(59),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.black26, width: 2.5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.category,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            LocaleKeys.sellerCreateProductScreen_category.tr(),
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 16.0),
                                          ),
                                          const Spacer(),
                                          DropdownButton(
                                            value: DashboardCubit.get(context)
                                                .createScreenDropDownValueEn,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: DashboardCubit.get(context)
                                                .createProductItemsEn.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              DashboardCubit.get(context)
                                                  .changeCreateProductDropButtonValue(
                                                      newValue);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  defaultFormField(
                                    type: TextInputType.name,
                                    prefix: Icons.text_fields_outlined,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return LocaleKeys.sellerCreateProductScreen_pleaseEnterProductName.tr();
                                      }
                                    },
                                    onChange: (v){
                                      if(v.length>18){
                                          log('true');
                                          nameController.text = nameController.text.substring(0, nameController.text.length - 1);
                                      }
                                    },
                                    isPassword: false,
                                    controller: nameController,
                                    label: LocaleKeys.sellerCreateProductScreen_productName.tr(),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  // defaultFormField(
                                  //   type: TextInputType.multiline,
                                  //   prefix: Icons.category,
                                  //   validate: (value) {
                                  //     if (value.isEmpty) {
                                  //       return "Please enter Description";
                                  //     }
                                  //   },
                                  //   isPassword: false,
                                  //   controller: descriptionController,
                                  //   label: "Description",
                                  // ),
                                  TextField(
                                    onSubmitted: (v) {
                                      description = '';
                                      description = v;
                                      isDescripted = true;
                                    },
                                    keyboardType: TextInputType.text,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black26,
                                            width: 2.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 2.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      labelText: LocaleKeys.sellerCreateProductScreen_description.tr(),
                                      prefixIcon: const Icon(Icons.text_fields),
                                    ),
                                  ),

                                  // const SizedBox(height: 5),
                                  // Row(
                                  //   children: const [
                                  //     Text(
                                  //       '*Must Fill Description',
                                  //       style: TextStyle(color: Colors.grey),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: const [
                                  //     Text(
                                  //       '*Must Select Category',
                                  //       style: TextStyle(color: Colors.grey),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: const [
                                  //     Text(
                                  //       '*Must Select images',
                                  //       style: TextStyle(color: Colors.grey),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        20.0,
                                  ),
                                  // defaultButton(
                                  //   width: MediaQuery.of(context).size.width / 2,
                                  //   height: 50.0,
                                  //   radius: 25.0,
                                  //   function: () {
                                  //     DashboardCubit.get(context)
                                  //         .uploadToFireBase();
                                  //   },
                                  //   text: 'uploadImage',
                                  // ),
                                  ConditionalBuilder(
                                    condition:
                                        state is! CreateProductLoadingState,
                                    builder: (context) => defaultButton(
                                      width: MediaQuery.of(context).size.width,
                                      radius: 20.0,
                                      height: 50.0,
                                      text: LocaleKeys.sellerCreateProductScreen_continue.tr(),
                                      function: () {
                                        if (formKey.currentState.validate() &&
                                            isDescripted &&
                                            DashboardCubit.get(context)
                                                    .createScreenDropDownValueEn !=
                                                'None' &&
                                            DashboardCubit.get(context)
                                                .listImage
                                                .isNotEmpty) {
                                          DashboardCubit.get(context)
                                              .uploadToFireBase();
                                          log(DashboardCubit.get(context).firebaseLink.toString());
                                          navigateTo(
                                              context,
                                              CreateProductScreen2(
                                                images:
                                                    DashboardCubit.get(context)
                                                        .firebaseLink,
                                                category: DashboardCubit.get(
                                                        context)
                                                    .createScreenDropDownValueEn,
                                                name: nameController.text,
                                                description: description,
                                              ));
                                        }
                                        else if(DashboardCubit.get(context)
                                            .listImage
                                            .isEmpty){
                                          showToast(text: LocaleKeys.sellerCreateProductScreen_pleaseSelectImage.tr(), state: ToastStates.error);
                                        }
                                        else if( DashboardCubit.get(context)
                                            .createScreenDropDownValueEn ==
                                            'None'){
                                          showToast(text: LocaleKeys.sellerCreateProductScreen_categoryShouldNotBeNone.tr(), state: ToastStates.error);
                                        }
                                        else if(nameController.text.isEmpty){
                                          showToast(text: LocaleKeys.sellerCreateProductScreen_pleaseEnterProductName.tr(), state: ToastStates.error);
                                        }else if(!isDescripted){
                                          showToast(text: LocaleKeys.sellerCreateProductScreen_pleaseEnterDescription.tr(), state: ToastStates.error);
                                        }

                                      },
                                      background: Colors.black,
                                    ),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
