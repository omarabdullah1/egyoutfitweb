import '../../../models/user/user_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class ChangeDropState extends ShopStates {}

class GetOffersSuccessState extends ShopStates {}

class GetOffersErrorState extends ShopStates {}

class GetProductsSuccessState extends ShopStates {}

class GetProductsErrorState extends ShopStates {}

class GetProductsLoadingState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class GetCartPriceState extends ShopStates {}

class ShopLoginSuccessState extends ShopStates
{
  final UserModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopStates
{
  final String error;

  ShopLoginErrorState(this.error);
}

class AddFavouritesSuccessState extends ShopStates {}

class AddFavouritesErrorState extends ShopStates {}

class UpdateFavouritesSuccessState extends ShopStates {}

class UpdateFavouritesErrorState extends ShopStates {}

class RemoveFavouritesSuccessState extends ShopStates {}

class RemoveFavouritesErrorState extends ShopStates {}

class AddCartSuccessState extends ShopStates {}

class AddCartErrorState extends ShopStates {}

class UpdateCartSuccessState extends ShopStates {}

class UpdateCartErrorState extends ShopStates {}

class RemoveCartSuccessState extends ShopStates {}

class RemoveCartErrorState extends ShopStates {}

class ChangeCounterState extends ShopStates {}

class ChangeCartPriceState extends ShopStates {}

class ChangeCartProductPriceState extends ShopStates {}

class CreateOrderSuccessState extends ShopStates {}

class CreateOrderErrorState extends ShopStates {}

class CreateOrderLoadingState extends ShopStates {}

class ShopLogoutState extends ShopStates {}

class UpdateStateLoadingShopState extends ShopStates {}

class UpdateStateSuccessShopState extends ShopStates {}

class UpdateStateErrorShopState extends ShopStates {}

class ChangePaymentMethodState extends ShopStates {}

class ChangeCartCounterState extends ShopStates {}

class ChangeCarouselState extends ShopStates {}

class ChangeLanguageState extends ShopStates {}

class ChangeSizedState extends ShopStates {}

class GetPromoCodesLoadingState extends ShopStates {}

class GetPromoCodesSuccessState extends ShopStates {}

class GetPromoCodesErrorState extends ShopStates {}

class ShopSendMessagesSuccessState extends ShopStates {}

class ShopSendMessagesErrorState extends ShopStates {}

class ShopGetAllMessagesSuccessState extends ShopStates {}

class GetSellerIDLoadingState extends ShopStates {}

class GetSellerIDSuccessState extends ShopStates {}

class ChangeIsErrorState extends ShopStates {}

class ChangePasswordVisibilityState extends ShopStates {}

class ShopRegisterChangeDropValueState extends ShopStates {}

class GetDataSuccessState extends ShopStates {}

class GetDataLoadingState extends ShopStates {}
class SLoadingState extends ShopStates {}
class FSuccessState extends ShopStates {}
