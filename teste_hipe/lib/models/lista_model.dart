import 'package:hive/hive.dart';
import 'package:teste_hipe/models/item_model.dart';

part 'lista_model.g.dart';

@HiveType(typeId: 3)
class Lista {
  @HiveField(0)
  DateTime data;
  @HiveField(1)
  String unidade;
  @HiveField(2)
  String tipo;
  @HiveField(3)
  bool enviada;
  @HiveField(4)
  List<Item> itens;

  Lista({
    required this.data,
    required this.unidade,
    required this.tipo,
    required this.enviada,
    required this.itens,
  });

  Lista copyWith({
    DateTime? data,
    String? unidade,
    String? tipo,
    bool? enviada,
    List<Item>? itens,
  }) =>
      Lista(
        data: data ?? this.data,
        unidade: unidade ?? this.unidade,
        tipo: tipo ?? this.tipo,
        enviada: enviada ?? this.enviada,
        itens: itens ?? this.itens,
      );
}
