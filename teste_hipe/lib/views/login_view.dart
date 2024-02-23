import 'package:flutter/material.dart';
import 'package:teste_hipe/controllers/auth_controller.dart';
import 'package:teste_hipe/utils/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthController _authController;

  @override
  void initState() {
    _authController = AuthController();
    _authController.verificarUser().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Bem vindo(a)',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              MyTextFormField(
                controller: _authController.loginEmailTextController,
                icon: const Icon(Icons.person),
                labelName: 'E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              MyTextFormField(
                controller: _authController.loginSenhaTextController,
                icon: const Icon(Icons.lock),
                labelName: 'Senha',
                isObscure: true,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  _authController.login(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                  child: Text('Login'),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: const Text('Não possui uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
