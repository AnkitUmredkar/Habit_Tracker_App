import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget{
  final Map<DateTime, int> datesets;
  final DateTime startDate;

  const MyHeatMap({
    super.key,
    required this.startDate,
    required this.datesets,
});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate : DateTime.now(),
      datasets: datesets,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.inversePrimary,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
        6: Colors.green.shade700,
        7: Colors.green.shade800,
        8: Colors.green.shade900,
      },
    );
  }
}