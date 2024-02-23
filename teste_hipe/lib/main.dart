import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:teste_hipe/models/item_model.dart';
import 'package:teste_hipe/models/lista_model.dart';
import 'package:teste_hipe/models/user_model.dart';
import 'package:teste_hipe/services/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ListaAdapter());
  Hive.registerAdapter(ItemAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      title: 'Teste Hipe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: routes,
    );
  }
}
