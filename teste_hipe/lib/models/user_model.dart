import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String nome;
  @HiveField(1)
  String email;
  @HiveField(2)
  String senha;

  User({required this.nome, required this.email, required this.senha});
}
