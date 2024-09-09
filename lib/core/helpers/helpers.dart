import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:watergoal/data_layer/models/accomplishement.dart';
import 'package:watergoal/logic_presentation_layer/features/accomplishement/data/accomplishementData.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';


// ----------------------------------------- shared pref -----------------------------------------

// set value

Future<void> setSharedprefuserId(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}


Future<void> setSharedprefTaskLauncher(String key, bool launchedvalue) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, launchedvalue);
}


// get value

Future<dynamic> getSharedprefuserId(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}


Future<dynamic> getSharedprefTaskLauncher(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

// ----------------------------------------- email validation & verification -----------------------------------------

final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);

bool isValidEmail(String email) {
  return emailRegex.hasMatch(email);
}

// ----------------------------------------- date operations -----------------------------------------

String dateChangeFormat(DateTime date){
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(date);
  return formattedDate;
}

String getCurrentDateStringFormat(){
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}


String getDateSevenDaysAgoStringFormat() {
  DateTime now = DateTime.now();
  DateTime sevenDaysAgo = now.subtract(Duration(days: 7));
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(sevenDaysAgo);
}


// ---------------------------- task scheduling ----------------------


void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      print("Task started: $task");
      print("Input data: $inputData");
      Accomplishement accomplishement = Accomplishement(
        userid: inputData!['userId'],
        percentageWaterValue: inputData['percentageWaterValue'],
        percentageDate: inputData['percentageDate'],
      );
      await accomplishementRepository.addAccomplishment(accomplishement);
      print("Accomplishment added: $accomplishement");
      return Future.value(true);
    } catch (e) {
      print("Error in task execution: $e");
      return Future.value(false);
    }
  });
}

void taskLaunching(int frequencyhour, int initialDelayMinute) async {
  print("Launching add accomp tasks");
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  int userId = await getSharedprefuserId('user_id');
  int percentageWaterValue = await userRepository.getPercentageWaterByUserId(userId);
  Workmanager().registerPeriodicTask(
    "AddAccomplishment",
    "dailyAccomplishmentTask",
    frequency: Duration(hours: frequencyhour),
    initialDelay: Duration(minutes: initialDelayMinute),
    inputData: {
      'userId': userId,
      'percentageWaterValue': percentageWaterValue,
      'percentageDate': getCurrentDateStringFormat()
    },
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isTaskLaunched', true);
}