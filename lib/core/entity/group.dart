import 'package:hive/hive.dart';

part 'group.g.dart';
//flutter packages pub run build_runner watch
//Запустив эту команду мы сгенерируем group.g.dart (адаптер) плюс он будет
//автоматически перегенироваться
@HiveType(typeId: 1)
class Group {
  @HiveField(0)
  String name;
  @HiveField(1)
  //HiveList - используется для хранения связей
  HiveList? tasks;

  Group({required this.name});
  
}