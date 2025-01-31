// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoriteItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteItemAdapter extends TypeAdapter<FavoriteItem> {
  @override
  final int typeId = 2;

  @override
  FavoriteItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteItem(
      userId: fields[0] as int,
      productId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
