import 'package:e_commerce_tharwat_samy/models/user_model.dart';

abstract class LoginNavigator {
  void navigateToRegisterScreen();
  void showLoading ();
  void hideLoading ();
  void showMessage (String message);
  void navigateToMajor (UserModel userModel);
  void navigateToAdminScreen ();
}