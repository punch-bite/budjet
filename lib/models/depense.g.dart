// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepenseAdapter extends TypeAdapter<Depense> {
  @override
  final int typeId = 0;

  @override
  Depense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Depense(
      type: fields[0] as String,
      name: fields[1] as String,
      montant: fields[2] as String,
      created_at: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Depense obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.montant)
      ..writeByte(3)
      ..write(obj.created_at);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
