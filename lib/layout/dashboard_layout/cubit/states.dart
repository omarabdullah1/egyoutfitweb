import '../../../models/user/user_model.dart';

abstract class DashboardStates {}

class DashboardInitialState extends DashboardStates {}

class DashboardChangeBottomNavState extends DashboardStates {}

class ChangeDropDashboardState extends DashboardStates {}

class ChangeDropRequestState extends DashboardStates {}

class ChangeUpdateDashboardState extends DashboardStates {}

class UpdateStateLoadingDashboardState extends DashboardStates {}

class UpdateStateSuccessDashboardState extends DashboardStates {}

class UpdateStateErrorDashboardState extends DashboardStates {}

class UpdateLocationLoadingDashboardState extends DashboardStates {}

class UpdateLocationSuccessDashboardState extends DashboardStates {}

class UpdateLocationErrorDashboardState extends DashboardStates {}

class ChangeStateDashboardState extends DashboardStates {}

class ChangeCreateProductDropDashboardState extends DashboardStates {}

class LoadingPickImageState extends DashboardStates {}

class SuccessPickImageState extends DashboardStates {}

class SuccessRemoveImageState extends DashboardStates {}

class ErrorPickImageState extends DashboardStates {}

class SuccessUploadImageState extends DashboardStates {}

class SuccessUploadAllImageState extends DashboardStates {}

class ErrorUploadImageState extends DashboardStates {}

class LoadingUploadImageState extends DashboardStates {}

class CreateProductLoadingState extends DashboardStates {}

class CreateProductSuccessState extends DashboardStates {}

class CreateProductErrorState extends DashboardStates {}

class UpdateProductLoadingState extends DashboardStates {}

class UpdateProductSuccessState extends DashboardStates {}

class UpdateProductErrorState extends DashboardStates {}

class UpdateProductImageLoadingState extends DashboardStates {}

class UpdateProductImageSuccessState extends DashboardStates {}

class UpdateProductImageErrorState extends DashboardStates {}

class CreatePromoLoadingState extends DashboardStates {}

class CreatePromoSuccessState extends DashboardStates {}

class CreatePromoErrorState extends DashboardStates {}

class GetProductsSuccessState extends DashboardStates {}

class GetProductsErrorState extends DashboardStates {}

class GetUsersSuccessState extends DashboardStates {}

class GetUsersErrorState extends DashboardStates {}

class DashboardLoginLoadingState extends DashboardStates {}

class DashboardLogoutState extends DashboardStates {}

class ChangeSizedState extends DashboardStates {}

class ChangeDayState extends DashboardStates {}

class ChangeCarouselState extends DashboardStates {}

class ChangeToggleValueState extends DashboardStates {}

class ChangeLanguageState extends DashboardStates {}

class GetOffersSuccessState extends DashboardStates {}

class GetOffersErrorState extends DashboardStates {}

class RemoveProductSuccessState extends DashboardStates {}

class RemoveProductErrorState extends DashboardStates {}

class GetPromoCodesLoadingState extends DashboardStates {}

class GetPromoCodesSuccessState extends DashboardStates {}

class GetPromoCodesErrorState extends DashboardStates {}

class SellerSendMessagesSuccessState extends DashboardStates {}

class SellerSendMessagesErrorState extends DashboardStates {}

class SellerGetAllMessagesSuccessState extends DashboardStates {}

class ShopRegisterChangeDropValueState extends DashboardStates {}

class DeleteUserSuccessState extends DashboardStates {}
class DeleteUserErrorState extends DashboardStates {}

class UnDeleteUserSuccessState extends DashboardStates {}
class UnDeleteUserErrorState extends DashboardStates {}

class SearchLoadingState extends DashboardStates {}

class SearchSuccessState extends DashboardStates {}


class LoadingState extends DashboardStates {}
class SuccessState extends DashboardStates {}

class DashboardLoginSuccessState extends DashboardStates {
  final UserModel loginModel;
  DashboardLoginSuccessState(this.loginModel);
}

class DashboardLoginErrorState extends DashboardStates {
  final String error;

  DashboardLoginErrorState(this.error);
}
