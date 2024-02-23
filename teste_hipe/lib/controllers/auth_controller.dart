import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_hipe/models/user_model.dart';
import 'package:teste_hipe/repositories/auth_repository.dart';
import 'package:teste_hipe/utils/widgets.dart';
part 'auth_controller.g.dart';

class AuthController = AuthControllerBase with _$AuthController;

User? userLogado;

abstract class AuthControllerBase with Store {
  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController loginEmailTextController =
      TextEditingController();

  final TextEditingController loginSenhaTextController =
      TextEditingController();

  final TextEditingController cadastroNomeTextController =
      TextEditingController();

  final TextEditingController cadastroEmailTextController =
      TextEditingController();

  final TextEditingController cadastroSenhaTextController =
      TextEditingController();

  final TextEditingController cadastroConfirmarSenhaTextController =
      TextEditingController();

  final cadastroNomeFormKey = GlobalKey<FormState>();
  final cadastroEmailFormKey = GlobalKey<FormState>();
  final cadastroSenhaFormKey = GlobalKey<FormState>();
  final cadastroConfirmarSenhaFormKey = GlobalKey<FormState>();

  @action
  Future<bool> verificarUser() async {
    var box = await Hive.openBox<User>('User');
    userLogado = box.get('user');
    return userLogado != null ? true : false;
  }

  bool validarCadastro() {
    bool isValid = false;
    isValid = cadastroNomeFormKey.currentState!.validate();
    isValid = cadastroEmailFormKey.currentState!.validate();
    isValid = cadastroSenhaFormKey.currentState!.validate();
    isValid = cadastroConfirmarSenhaFormKey.currentState!.validate();
    return isValid;
  }

  @action
  Future newUser(BuildContext context) async {
    if (validarCadastro()) {
      final user = User(
        nome: cadastroNomeTextController.text,
        email: cadastroEmailTextController.text,
        senha: cadastroSenhaTextController.text,
      );
      final response = await _authRepository.newUser(user);
      if (context.mounted) {
        if (response['status'] == false) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message: response['message']);
            },
          );
        } else {
          var box = await Hive.openBox<User>('User');
          userLogado = user;
          box.put('user', user).then(
            (value) {
              Navigator.pushReplacementNamed(context, '/home');
            },
          );
        }
      }
    }
  }

  @action
  Future login(BuildContext context) async {
    final response = await _authRepository.login(
        loginEmailTextController.text, loginSenhaTextController.text);
    if (context.mounted) {
      if (response['status'] == false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: response['message']);
          },
        );
      } else {
        var box = await Hive.openBox<User>('User');
        userLogado = response['user'];
        box.put('user', userLogado!).then(
          (value) {
            Navigator.pushReplacementNamed(context, '/home');
          },
        );
      }
    }
  }
}
