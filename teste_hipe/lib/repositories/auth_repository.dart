import 'package:hive/hive.dart';
import 'package:teste_hipe/interfaces/auth_repository_interface.dart';
import 'package:teste_hipe/models/user_model.dart';

class AuthRepository extends IAuthRepository {
  @override
  Future newUser(User user) async {
    var box = await Hive.openBox<User>('AuthBox');
    var isRegistered = box.get(user.email);
    if (isRegistered != null) {
      return {'status': false, 'message': 'E-mail já registrado.'};
    } else {
      await box.put(user.email, user);
      return {'status': true, 'message': 'Usuario cadastrado com sucesso.'};
    }
  }

  @override
  Future login(String email, String senha) async {
    var box = await Hive.openBox<User>('AuthBox');
    var user = box.get(email);
    if (user == null) {
      return {'status': false, 'message': 'E-mail não registrado no sistema.'};
    } else {
      if (user.senha == senha) {
        return {
          'status': true,
          'message': 'Login realizado com sucesso.',
          'user': user,
        };
      } else {
        return {'status': false, 'message': 'Senha incorreta.'};
      }
    }
  }
}
