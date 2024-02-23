import 'package:flutter/material.dart';
import 'package:teste_hipe/controllers/auth_controller.dart';
import 'package:teste_hipe/utils/widgets.dart';
import 'package:validatorless/validatorless.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  late AuthController _authController;

  @override
  void initState() {
    _authController = AuthController();
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
              Form(
                key: _authController.cadastroNomeFormKey,
                child: MyTextFormField(
                  controller: _authController.cadastroNomeTextController,
                  icon: const Icon(Icons.person),
                  labelName: 'Nome',
                  validator: Validatorless.required('Campo obrigatório'),
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: _authController.cadastroEmailFormKey,
                child: MyTextFormField(
                  controller: _authController.cadastroEmailTextController,
                  icon: const Icon(Icons.email),
                  labelName: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.email('O campo deve ser um e-mail valído')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: _authController.cadastroSenhaFormKey,
                child: MyTextFormField(
                  controller: _authController.cadastroSenhaTextController,
                  icon: const Icon(Icons.lock),
                  labelName: 'Senha',
                  isObscure: true,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.min(
                          6, 'A senha deve conter ao menos 6 caracteres'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: _authController.cadastroConfirmarSenhaFormKey,
                child: MyTextFormField(
                  controller:
                      _authController.cadastroConfirmarSenhaTextController,
                  icon: const Icon(Icons.lock),
                  labelName: 'Confirmar Senha',
                  isObscure: true,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.compare(
                          _authController.cadastroSenhaTextController,
                          'As senhas devem ser iguais')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  _authController.newUser(context);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                  child: Text('Cadastrar'),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Já possui uma conta? Realize o Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
