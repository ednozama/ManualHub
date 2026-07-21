// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceAdapter extends TypeAdapter<Device> {
  @override
  final int typeId = 0;

  @override
  Device read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Device(
      manufacturer: fields[0] as String,
      model: fields[1] as String,
      category: fields[2] as String,
      location: fields[3] as String,
      imagePath: fields[4] as String?,
      manualPath: fields[5] as String?,
      invoicePath: fields[6] as String?,
      warrantyPath: fields[7] as String?,
      history: (fields[8] as List?)?.cast<HistoryEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, Device obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.manufacturer)
      ..writeByte(1)
      ..write(obj.model)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.manualPath)
      ..writeByte(6)
      ..write(obj.invoicePath)
      ..writeByte(7)
      ..write(obj.warrantyPath)
      ..writeByte(8)
      ..write(obj.history);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
