import '../../learn/learn_get_it.dart';
import '../common_export.dart';
import 'auth_service.dart';

class AuthModel extends ChangeNotifier {
  AuthEnum get currentAuth => getIt<AuthService>().currentAuth;
  set currentAuth(AuthEnum authEnum) {
    getIt<AuthService>().changeCurrentAuth(authEnum);
    notifyListeners();
  }
}