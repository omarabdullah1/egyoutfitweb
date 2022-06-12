import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/service_provider/search_screen/search_screen.dart';
import '../../modules/user/search/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../translations/locale_keys.g.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({Key key}) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  @override
  void initState() {
    DashboardCubit.get(context).userLogin(
        context: context,
        email: CacheHelper.getData(key: 'user'),
        password: CacheHelper.getData(key: 'pass'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DashboardCubit.get(context);
        var widthQuarter = MediaQuery.of(context).size.width / 3;
        var width = MediaQuery.of(context).size.width;
        return FutureBuilder(
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(context, const SearchScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 10.0),
                        child: Container(
                          width: width - widthQuarter,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              Text(
                                LocaleKeys.usersHomeScreen_searchInEgyOutfit
                                    .tr(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await DashboardCubit.get(context).getAllProducts();
                      await DashboardCubit.get(context).getAllOrdered(context);
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              resizeToAvoidBottomInset: false,
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: Image.asset('assets/images/Egy-Outfit-Black.png'),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      title: Text(LocaleKeys.dashboardScreen_allProducts.tr()),
                      onTap: () {
                        cubit.changeBottom(0);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.home),
                    ),
                    ListTile(
                      title:  Text(LocaleKeys.dashboardScreen_requests.tr()),
                      onTap: () {
                        cubit.changeBottom(1);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.request_page),
                    ),
                    ListTile(
                      title: Text(LocaleKeys.userAccountScreen_mySettings.tr()),
                      onTap: () {
                        cubit.changeBottom(2);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
              body: cubit.bottomScreens[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}
