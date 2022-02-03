// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 1;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      task: fields[0] as String,
      detail: fields[1] as String,
      category: fields[2] as String,
      addedOn: fields[3] as DateTime,
      modifiedOn: fields[4] as DateTime?,
      completed: fields[5] as bool,
      completedOn: fields[6] as DateTime?,
      startDateTime: fields[7] as DateTime?,
      endDateTime: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.detail)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.addedOn)
      ..writeByte(4)
      ..write(obj.modifiedOn)
      ..writeByte(5)
      ..write(obj.completed)
      ..writeByte(6)
      ..write(obj.completedOn)
      ..writeByte(7)
      ..write(obj.startDateTime)
      ..writeByte(8)
      ..write(obj.endDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
