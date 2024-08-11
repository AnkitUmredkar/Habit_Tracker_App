import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const MyHabitTile(
      {super.key,
        required this.text,
        required this.isCompleted,
        required this.onChanged,
        required this.editHabit,
        required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
      child: Slidable(
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          // edit option
          SlidableAction(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            onPressed: editHabit,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(8),
          ),

          // delete option
          SlidableAction(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            onPressed: deleteHabit,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          ),
        ]),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.only(right: 10),
            child: ListTile(
              title: Text(text,style: TextStyle(color: isCompleted ? Colors.white : Theme.of(context).colorScheme.inversePrimary),),
              leading: Checkbox(
                  activeColor: Colors.green,
                  value: isCompleted,
                  onChanged: onChanged),
            ),
          ),
        ),
      ),
    );
  }
}
