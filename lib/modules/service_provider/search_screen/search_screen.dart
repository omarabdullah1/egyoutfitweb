import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    DashboardCubit.get(context).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      searchFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        isValidate: true,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return LocaleKeys.usersHomeScreen_enterTextToSearch.tr();
                          }

                          return null;
                        },
                        onSubmit: (String text) {
                          if(formKey.currentState.validate()){
                            DashboardCubit.get(context).search(text);
                          }
                        },
                        label: LocaleKeys.usersHomeScreen_search.tr(),
                        prefix: Icons.search,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildSearchListProduct(
                                isOldPrice: false,
                                model: DashboardCubit.get(context).productsSearched[index],
                                context: context,
                                idList: DashboardCubit.get(context).productsSearchedID,
                                index: index
                            ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount:
                            DashboardCubit.get(context).productsSearched.length,
                          ),
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
