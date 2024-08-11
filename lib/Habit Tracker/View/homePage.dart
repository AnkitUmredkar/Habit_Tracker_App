import 'package:database/Habit%20Tracker/Components/my_heat_map.dart';
import 'package:database/Habit%20Tracker/Controller/habitController.dart';
import 'package:database/Habit%20Tracker/Database/habit_database.dart';
import 'package:database/Habit%20Tracker/Model/habitModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Components/my_habit_tile.dart';
import '../utils/habit_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void checkHabitOnOff(bool? value, Habit habit, BuildContext context) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  void editHabitBox(
      Habit habit, BuildContext context, HabitController habitControllerTrue) {
    textController.text = habit.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                cursorColor: habitControllerTrue.isDark
                    ? Colors.black87
                    : Colors.white70,
                controller: textController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: habitControllerTrue.isDark
                        ? Colors.black87
                        : Colors.white70,
                  )),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      String newHabitName = textController.text;
                      String msg = '';
                      if (newHabitName == '') {
                        msg = "Habit Can't Empty";
                      } else {
                        msg = 'Habit Edited Successfully';
                        context.read<HabitDatabase>().updateHabitName(habit.id, newHabitName);
                        Navigator.pop(context);
                        textController.clear();
                      }
                      Fluttertoast.showToast(
                        msg: msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.blue.shade700),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue.shade700),
                    ))
              ],
            ));
  }

  void deleteHabitBox(Habit habit, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Are you sure you want to delete'),
              actions: [
                TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: 'Habit Delete Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                      context.read<HabitDatabase>().deleteHabit(habit.id);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.blue.shade700),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue.shade700),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double habitListHeight = height * 0.095;
    HabitController habitControllerFalse =
        Provider.of<HabitController>(context, listen: false);
    HabitController habitControllerTrue =
        Provider.of<HabitController>(context, listen: true);
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    void createNewHabit() {
      textController = TextEditingController();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: TextField(
                cursorColor: habitControllerTrue.isDark
                    ? Colors.black87
                    : Colors.white70,
                controller: textController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: habitControllerTrue.isDark
                          ? Colors.black87
                          : Colors.white70,
                    )),
                    hintText: 'Create a new habit'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      String newHabitName = textController.text;
                      String msg = '';
                      if (newHabitName == '') {
                        msg = "Habit Can't Empty";
                      } else {
                        msg = "Habit Added Successfully";
                        context.read<HabitDatabase>().addHabit(newHabitName);
                        Navigator.pop(context);
                        textController.clear();
                      }
                      Fluttertoast.showToast(
                        msg: msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.blue.shade700),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue.shade700),
                    ))
              ],
            );
          });
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 68,
          leading: const Icon(Icons.menu),
          centerTitle: true,
          title: const Text('Habit Tracker'),
          actions: [
            (habitControllerTrue.isDark)
                ? IconButton(
                    onPressed: () {
                      habitControllerFalse.setTheme();
                    },
                    icon: const Icon(Icons.dark_mode))
                : IconButton(
                    onPressed: () {
                      habitControllerFalse.setTheme();
                    },
                    icon: const Icon(Icons.light_mode_sharp))
          ],
        ),
        body: Column(
          children: [
            _buildHeatMap(context),
            const SizedBox(height: 10),
            Expanded(
                child: SingleChildScrollView(
                  child: ExpansionTile(
                      iconColor: Theme.of(context).colorScheme.inversePrimary,
                      title: const Text('Your Habits'),
                      children: [_buildHabitList(context, habitControllerTrue)]),
                )),
          ],
        ),
        // child: Column(
        //   children: [
        //     HeatMapCalendar(
        //       showColorTip: false,
        //       defaultColor: Colors.white,
        //       flexible: true,
        //       colorMode: ColorMode.color,
        //       colorsets: const {
        //         1: Colors.red,
        //         3: Colors.orange,
        //         5: Colors.yellow,
        //         7: Colors.green,
        //         9: Colors.blue,
        //         11: Colors.indigo,
        //         13: Colors.purple,
        //       },
        //       onClick: (value) {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(content: Text(value.toString())));
        //       },
        //     ),
        //     SizedBox(height: 15,),
        //     Expanded(
        //       child: SingleChildScrollView(
        //         child: ExpansionTile(
        //             title: const Text('Habits'),
        //             trailing: const Icon(Icons.arrow_drop_down, size: 25),
        //             children: List.generate(
        //                 habitControllerTrue.habitsList.length,
        //                     (index) => Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Slidable(
        //                     endActionPane: ActionPane(
        //                         motion: const DrawerMotion(), //DrawerMotion, StretchMotion, ScrollMotion, BehindMotion
        //                         children: [
        //                           Expanded(
        //                             child: GestureDetector(
        //                               onTap: () {
        //                                 habitControllerFalse.editHabit(
        //                                     context, index);
        //                               },
        //                               child: buildOptions(
        //                                   habitListHeight,
        //                                   Icons.edit,
        //                                   const Color(0xff424242)),
        //                             ),
        //                           ),
        //                           Expanded(
        //                             child: GestureDetector(
        //                               onTap: () {
        //                                 habitControllerFalse.deleteHabit(index,context);
        //                               },
        //                               child: buildOptions(habitListHeight,
        //                                   Icons.delete, Colors.red),
        //                             ),
        //                           ),
        //                         ]),
        //                     child: Container(
        //                       height: habitListHeight,
        //                       alignment: Alignment.center,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(11),
        //                         color: (habitControllerFalse.isDark)
        //                             ? Colors.white
        //                             : const Color(0xff25262d),
        //                       ),
        //                       child: ListTile(
        //                         leading: Checkbox(
        //                           value: false,
        //                           onChanged: (value) => () {},
        //                         ),
        //                         title:
        //                         Text(habitControllerTrue.habitsList[index]),
        //                       ),
        //                     ),
        //                   ),
        //                 ))),
        //       ),
        //     ),
        //   ],
        // ),

        floatingActionButton: GestureDetector(
          onTap: () {
            createNewHabit();
          },
          child: floatingButton(width, habitControllerTrue),
        ),
      ),
    );
  }

  // todo build heat map
  Widget _buildHeatMap(BuildContext context) {
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDatabase.currentHabits;

    return FutureBuilder(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHeatMap(
              startDate: snapshot.data!,
              datesets: prepHeatMapDataset(currentHabits));
        } else {
          return Container();
        }
      },
    );
  }

  // todo build habit list
  Widget _buildHabitList(
      BuildContext context, HabitController habitControllerTrue) {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return MyHabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (value) => checkHabitOnOff(value, habit, context),
            editHabit: (context) => editHabitBox(habit, context, habitControllerTrue),
            deleteHabit: (context) => deleteHabitBox(habit, context));
      },
    );
  }

  //todo FloatingActionButton
  Container floatingButton(double width, HabitController habitControllerTrue) {
    return Container(
      height: width * 0.1775,
      width: width * 0.1775,
      decoration: BoxDecoration(
          color: (habitControllerTrue.isDark)
              ? Colors.white
              : const Color(0xff25262d),
          boxShadow: const [
            BoxShadow(
                offset: Offset(7.5, 7.5),
                blurRadius: 10,
                color: Colors.black54),
          ],
          shape: BoxShape.circle),
      child: Icon(Icons.add, color: Colors.blue.shade700, size: width * 0.071),
    );
  }
}

Container buildOptions(double habitListHeight, var icon, Color color) {
  return Container(
    height: habitListHeight,
    margin: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Icon(
      icon,
      color: Colors.white,
    ),
  );
}
