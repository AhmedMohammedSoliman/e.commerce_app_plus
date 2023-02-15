import '../../models/user_model.dart';

abstract class RegisterNavigator {
void showLoading ();
void hideLoading ();
void showMessage (String message);
void navigateToMajor (UserModel userModel);
}