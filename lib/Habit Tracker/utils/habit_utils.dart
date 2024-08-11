import 'package:flutter/material.dart';

import '../Model/habitModel.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
  date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}

//todo Prepare heat map dateset

Map<DateTime, int> prepHeatMapDataset(List<Habit> habits){
  Map<DateTime, int> dataset = {};

  for(var habit in habits){
    for(var date in habit.completedDays){
      final normalizedDate = DateTime(date.year, date.month, date.day);

      if(dataset.containsKey(normalizedDate)){
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      }
      else{
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}


//todo intro screen
Widget buildPage(
    double height, double width, String img, String title, String description,double pad) {
  return Container(
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        color: Color(0xff202020)
    ),
    height: height,
    width: width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: pad),
          child: Image.asset(img,height: height * 0.28,),
        ),
        SizedBox(height: height * 0.051),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'montR',
                fontWeight: FontWeight.bold,
                fontSize: width * 0.0265),
          ),
        ),
        SizedBox(height: height * 0.04),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'montR',
                fontWeight: FontWeight.bold,
                fontSize: width * 0.0172),
          ),
        ),
      ],
    ),
  );
}
