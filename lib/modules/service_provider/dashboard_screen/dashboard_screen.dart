import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../create_product/create_product1.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    DashboardCubit.get(context).getAllProducts();
    Timer(const Duration(milliseconds: 500), () {
      DashboardCubit.get(context).getAllOrdered(context);
      DashboardCubit.get(context).getPromoCodes();
      DashboardCubit.get(context).changeDropButtonValue(
        EasyLocalization.of(context).locale.languageCode == 'en'
            ? DashboardCubit.get(context).lastDropDownValueEn
            : DashboardCubit.get(context).lastDropDownValueAr,
        context,
      );
      DashboardCubit.get(context).isEnglish =
      EasyLocalization.of(context).locale.languageCode == 'en' ? true : false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return BlocConsumer<DashboardCubit, DashboardStates>(
        listener: (context, states) {},
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: 'uniqueTag',
              onPressed: () {
                navigateTo(context, const CreateProductScreen());
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.black,
            ),
            body: RefreshIndicator(
              onRefresh: () {
                DashboardCubit.get(context).getAllProducts();
                DashboardCubit.get(context).getAllOrdered(context);
                DashboardCubit.get(context).getPromoCodes();
                return;
              },
              child: Column(
                children: [
                  Expanded(
                    child: BuildAllProducts(
                      screenWidth: width,
                      model: DashboardCubit.get(context).products,
                      modelIDList: DashboardCubit.get(context).productsID,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    DashboardCubit.get(context).getAllProducts();
    Timer(const Duration(milliseconds: 500), () {
      DashboardCubit.get(context).getAllOrdered(context);
      DashboardCubit.get(context).getPromoCodes();
      DashboardCubit.get(context).changeDropButtonValue(
        EasyLocalization.of(context).locale.languageCode == 'en'
            ? DashboardCubit.get(context).lastDropDownValueEn
            : DashboardCubit.get(context).lastDropDownValueAr,
        context,
      );
      DashboardCubit.get(context).isEnglish =
      EasyLocalization.of(context).locale.languageCode == 'en' ? true : false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<DashboardCubit, DashboardStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'uniqueTag',
        onPressed: () {
          navigateTo(context, const CreateProductScreen());
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          DashboardCubit.get(context).getAllProducts();
          DashboardCubit.get(context).getAllOrdered(context);
          DashboardCubit.get(context).getPromoCodes();
          return;
        },
        child: Column(
          children: [
            Expanded(
              child: buildRequests(
                  context: context,
                  width: width,
                  ordersModel:
                  DashboardCubit.get(context).requestOrderModel,
                  model: DashboardCubit.get(context).requestModel,
                  countList: DashboardCubit.get(context)
                      .requestModelCountList,
                  id: DashboardCubit.get(context)
                      .requestedOrderedProductsID),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
