import 'package:isar/isar.dart';

part 'habitModel.g.dart';

@Collection()
class Habit{
  Id id = Isar.autoIncrement;

  late String name;
  List<DateTime> completedDays = [];
}
