import '../../../models/user/user_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates
{
  final UserModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}

class AppChangeModeState extends ShopLoginStates {}

class AppChangeLanguageState extends ShopLoginStates {}

class ResetPasswordLoadingState extends ShopLoginStates {}

class ResetPasswordSuccessState extends ShopLoginStates {}

class ResetPasswordErrorState extends ShopLoginStates {}

class ShopLogoutState extends ShopLoginStates {}
