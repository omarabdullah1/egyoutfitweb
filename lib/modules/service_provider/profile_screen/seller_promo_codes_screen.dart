import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class PromoCodesScreen extends StatefulWidget {
  const PromoCodesScreen({Key key}) : super(key: key);

  @override
  State<PromoCodesScreen> createState() => _PromoCodesScreenState();
}

class _PromoCodesScreenState extends State<PromoCodesScreen> {
  @override
  void initState() {
    DashboardCubit.get(context).getPromoCodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Expanded(
                    child: Text(
                      LocaleKeys.sellerAcountScreen_myPromoCodes.tr()+':  ',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(const Duration(seconds: 2),
                            () async {
                          await DashboardCubit.get(context).getPromoCodes();
                        });
                      },
                      child: ListView.separated(
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width - 50.0,
                                  height: height / 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    border: Border.all(
                                      color: Colors.black54,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(LocaleKeys.sellerAcountScreen_promoCode.tr()+':  '),
                                            Text(DashboardCubit.get(context)
                                                .myPromoCodesList[index]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(LocaleKeys.sellerAcountScreen_discount.tr()+':  '),
                                            Text(DashboardCubit.get(context)
                                                    .myDiscountList[index]
                                                    .toString() +
                                                '%'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(LocaleKeys.sellerAcountScreen_state.tr()+':  '),
                                            Text(DashboardCubit.get(context)
                                                .myPromoCodesStateList[index]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount:
                            DashboardCubit.get(context).myPromoCodesList.length,
                      ),
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
