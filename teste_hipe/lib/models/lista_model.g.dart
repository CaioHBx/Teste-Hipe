// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListaAdapter extends TypeAdapter<Lista> {
  @override
  final int typeId = 3;

  @override
  Lista read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lista(
      data: fields[0] as DateTime,
      unidade: fields[1] as String,
      tipo: fields[2] as String,
      enviada: fields[3] as bool,
      itens: (fields[4] as List).cast<Item>(),
    );
  }

  @override
  void write(BinaryWriter writer, Lista obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.unidade)
      ..writeByte(2)
      ..write(obj.tipo)
      ..writeByte(3)
      ..write(obj.enviada)
      ..writeByte(4)
      ..write(obj.itens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
