import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    ShopCubit.get(context).getFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is AddFavouritesSuccessState) {
          showToast(
              text: LocaleKeys.alerts_productAddedToYourFavourites.tr(),
              state: ToastStates.success);
        } else if (state is RemoveFavouritesSuccessState) {
          showToast(
              text: LocaleKeys.alerts_productRemovedFromYourFavourites.tr(),
              state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return ShopCubit.get(context).favorites.isEmpty ||
                ShopCubit.get(context).favorites == null
            ? Center(
                child: Text(LocaleKeys.userFavouritesScreen_noProductsInFavouritesMessage.tr()),
              )
            : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildListProduct(
                        context: context,
                        model: ShopCubit.get(context).favoritesModel[index],
                        // index: index,
                        idList: ShopCubit.get(context).favorites,
                        index: index,
                      ),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: ShopCubit.get(context).favoritesModel.length,
                    ),
                ),
              ),
            );
      },
    );
  }
}
