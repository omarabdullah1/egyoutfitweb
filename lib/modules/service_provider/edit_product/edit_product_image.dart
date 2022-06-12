import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';

class EditProductImageScreen extends StatelessWidget {
  const EditProductImageScreen({
    Key key,
    this.pListImage,
    this.pId,
  }) : super(key: key);
  final String pId;
  final List pListImage;

  @override
  Widget build(BuildContext context) {
    DashboardCubit.get(context).listImage = [];
    DashboardCubit.get(context).firebaseLinkEdit = [];

    var caroController = CarouselController();
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_outlined)),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 2.0),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      state is LoadingUploadImageState?
                        const LinearProgressIndicator():const SizedBox(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(width: 2.0, color: Colors.black)),
                            child: CarouselSlider(
                              items: DashboardCubit.get(context).listImage.isEmpty
                                  ? pListImage.map((e) => Image.network(e)).toList()
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
                                autoPlayAnimationDuration: const Duration(seconds: 1),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal,
                              ),
                              carouselController: caroController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DotsIndicator(
                        dotsCount: DashboardCubit.get(context).listImage.isNotEmpty
                            ? DashboardCubit.get(context).listImage.length
                            : pListImage.isNotEmpty
                                ? pListImage.length
                                : 1,
                        position: DashboardCubit.get(context).caroIndex.toDouble(),
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
                      DashboardCubit.get(context).listImage.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom: 15.0,
                                  right: MediaQuery.of(context).size.width / 9,
                                  left: MediaQuery.of(context).size.width / 9),
                              child: SizedBox(
                                height: 100.0,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  // shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Semantics(
                                      child: Stack(
                                        children: [
                                          // Image.file(File(DashboardCubit.get(context)
                                          //     .listImage[index])),
                                          Positioned(
                                            top: 0.0,
                                            right: -15.0,
                                            child: SizedBox(
                                              height: 20.0,
                                              child: FloatingActionButton(
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                  size: 13.0,
                                                ),
                                                onPressed: () {
                                                  DashboardCubit.get(context)
                                                      .removeImageFromList(index);
                                                },
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      width: 10.0,
                                    );
                                  },
                                  itemCount:
                                      DashboardCubit.get(context).listImage.length,
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultButton(
                              function: () {
                                DashboardCubit.get(context).getMultiImage(false);
                                DashboardCubit.get(context).caroIndex = 0;
                              },
                              text: 'Photos',
                              background: Colors.black,
                              isIcon: true,
                              icon: Icons.image,
                              width: MediaQuery.of(context).size.width / 5.5,
                              height: 50.0,
                              radius: 25.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '*The added images will be added to old ',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              '   images not replacement ',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultButton(
                        function: () {
                          // DashboardCubit.get(context).uploadEditToFireBase(
                          //   pId: pId,
                          //   pListImage: pListImage,
                          //   context:context,
                          // );
                        },
                        text: 'upload',
                        background: Colors.black,
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: 50.0,
                        radius: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
