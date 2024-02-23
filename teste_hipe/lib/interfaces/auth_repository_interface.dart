import 'package:teste_hipe/models/user_model.dart';

abstract class IAuthRepository {
  Future newUser(User user);
  Future login(String email, String senha);
}
