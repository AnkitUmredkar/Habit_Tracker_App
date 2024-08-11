import 'package:database/Habit%20Tracker/Controller/habitController.dart';
import 'package:database/Habit%20Tracker/Database/habit_database.dart';
import 'package:database/Habit%20Tracker/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Habit Tracker/Theme/myTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HabitController(),),
        ChangeNotifierProvider(create: (context) => HabitDatabase(),),
      ],
      child: Builder(
        builder: (context) =>  MaterialApp(
          debugShowCheckedModeBanner: false,
            theme: MyTheme.lightMode,
            darkTheme: MyTheme.darkMode,
            themeMode: Provider.of<HabitController>(context,listen: true).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: const SplashScreen(),
          ),
      ),
    );
  }
}
