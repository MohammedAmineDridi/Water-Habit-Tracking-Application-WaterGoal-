import 'package:flutter/material.dart';
import 'package:watergoal/data_layer/models/user.dart';
import '../../logic_presentation_layer/getStarted.dart';
import '../../logic_presentation_layer/features/signup/ui/signUp.dart';
import '../../logic_presentation_layer/features/login/ui/login.dart';
import '../../logic_presentation_layer/features/weight_gender_selection/ui/bitAboutYourself.dart';
import '../../logic_presentation_layer/features/setDailyGoal/ui/setDailyGoal.dart';
import '../../logic_presentation_layer/features/stayHydrated/ui/stayHydrated.dart';
import '../../logic_presentation_layer/features/profileSettings/ui/profileSettings.dart';
import '../../logic_presentation_layer/features/accomplishement/ui/resultsStats.dart';

   Map<String, Widget Function(BuildContext context)> appRoutes = {
      "getStarted":(context) => Getstarted(),
      "SignUp":(context) => SignUp(),
      "Login":(context) => Login(),
      "userInfo":(context) => UserInfo(),
      "dailyGoal":(context) => SetDailyGoal(),
      "profileSettings": (context) {
      final User user = ModalRoute.of(context)!.settings.arguments as User;
      return ProfileSettings(user: user);
      },
      "stayHydrated":(context) => StayHydrated(),
      "resultStats":(context) => ResultStats(),
  };

  // got to function (navigation function)
  void goTo(BuildContext context, String routeNameDestination,{Object? arguments}){
    Navigator.of(context).pushReplacementNamed(routeNameDestination, arguments: arguments);
  }
