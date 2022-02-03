// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 0;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      name: fields[0] as String,
      todoList: (fields[1] as List).cast<TodoModel>(),
      sortBy: fields[2] as String,
      filterBy: fields[3] as String,
      createdOn: fields[4] as DateTime,
      defaultView: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.todoList)
      ..writeByte(2)
      ..write(obj.sortBy)
      ..writeByte(3)
      ..write(obj.filterBy)
      ..writeByte(4)
      ..write(obj.createdOn)
      ..writeByte(5)
      ..write(obj.defaultView);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
