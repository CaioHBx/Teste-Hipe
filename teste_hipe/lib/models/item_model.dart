import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 2)
class Item {
  @HiveField(0)
  String codigoBarras;
  @HiveField(1)
  DateTime dataValidade;
  @HiveField(2)
  String quantidadePorEmbalagem;
  @HiveField(3)
  String quantidade;

  Item({
    required this.codigoBarras,
    required this.dataValidade,
    required this.quantidadePorEmbalagem,
    required this.quantidade,
  });
}
