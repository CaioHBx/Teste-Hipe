// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 2;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      codigoBarras: fields[0] as String,
      dataValidade: fields[1] as DateTime,
      quantidadePorEmbalagem: fields[2] as String,
      quantidade: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.codigoBarras)
      ..writeByte(1)
      ..write(obj.dataValidade)
      ..writeByte(2)
      ..write(obj.quantidadePorEmbalagem)
      ..writeByte(3)
      ..write(obj.quantidade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
