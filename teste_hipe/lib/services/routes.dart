import 'package:flutter/material.dart';
import 'package:teste_hipe/views/cadastro_view.dart';
import 'package:teste_hipe/views/home_view.dart';
import 'package:teste_hipe/views/lista_view.dart';
import 'package:teste_hipe/views/login_view.dart';

final routes = {
  '/login': (context) => const LoginView(),
  '/cadastro': (context) => const CadastroView(),
  '/home': (context) => const HomeView(),
  '/lista': (context) => ListaView(
      args: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
};
