
import 'package:flutter/material.dart';

class AppStyles{

  // ----------------------------------- images -----------------------------------

  static String imageFemaleAvatar_non_selected = "assets/images/page4_a_bit_about_yourself/non_selected_female_avatar_scale_100.png";
  static String imageMaleAvatar_non_selected = "assets/images/page4_a_bit_about_yourself/non_selected_male_avatar_scale_100.png";
  static String imageFemaleAvatar_selected = "assets/images/page4_a_bit_about_yourself/selected_female_avatar_scale_100.png";
  static String imageMaleAvatar_selected = "assets/images/page4_a_bit_about_yourself/selected_male_avatar_scale_100.png";
  static String getStartedImage = "assets/images/page1_getstarted/getstarted.png";
  static String loginImage = "assets/images/page3_login/login.png";
  static String logoWaterGoal = "assets/images/logo_watergoal.png";
  static String millimeter_non_selected = "assets/images/page5_set_daily_goal/milliliter_non_selected.gif";
  static String millimeter_selected = "assets/images/page5_set_daily_goal/milliliter_selected.gif";
  static String ounce_non_selected = "assets/images/page5_set_daily_goal/oz_non_selected.gif";
  static String ounce_selected = "assets/images/page5_set_daily_goal/oz_selected.gif";

  // ----------------------------------- colors -----------------------------------
  static Color titleColor = Color(0xFF00008B);
  static Color titleBorderColor = Colors.blue.withOpacity(0.1);
  static Color subTitleColor = Color(0xFF00008B);
  static Color cardTextColor = Color(0xFF00008B);
  static Color textKeyColor = Colors.grey.withOpacity(0.6);
  static Color textValueColor = Color(0xFF00008B);
  static Color buttonColor = Colors.blue;
  static Color buttonTextColor = Colors.white;
  static Color hyperLinkTextColor = Colors.blue;
  static Color hyperTextColor = Colors.grey;
  static Color iconColor = Color(0xFF00008B);
  static Color sliderSlidingColor = Color(0xFF00008B);
  static Color sliderEmptyBarColor = Colors.grey.withOpacity(0.6);
  static Color avatarTextColor = Color(0xFF00008B);
  static LinearGradient cardColor = LinearGradient(
    colors: [Colors.blue.withOpacity(0.5), Color.fromARGB(255, 60, 60, 183).withOpacity(0.5)],
    stops: [0.3, 0.7], // Optional: position of color stops
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Color chartBarsColor = Colors.lightBlue.withOpacity(0.3);
  static Color chartBarTextColor = Color(0xFF00008B);
  static Color textFieldColor = Color(0xFF00008B);
  static Color linetextFieldColor = Color(0xFF00008B);
  static Color lineTextFieldBorderColor = Colors.blue;
  static Color textFieldCursorColor = Colors.grey.withOpacity(0.6);
  static Color textFieldTextHintColor = Colors.grey.withOpacity(0.6);
  static Color textFieldIconColor = Colors.grey.withOpacity(0.6);
  static Color bottleColor = Color(0xFF00008B);
  static Color bottleWaterColor = Colors.blue.withOpacity(0.4);
  static Color curvedLineColor = Colors.blue.withOpacity(0.4);
  static Color popupBackgroundColor = Colors.white;

  // ----------------------------------- fonts -----------------------------------

  static double titleFontSize = 30;
  static double subtitleFontSize = 20;
  static double textKeyFontSize = 16;
  static double textValueFontSize = 16;
  static double buttonTextFontSize = 16;
  static double hyperLinkTextFontSize = 14;
  static double cardTextFontSize = 20;
  static double chartBarTextFontSize = 14;
  static double avatarTextFontSize = 14;
  static double hyperTextFontSize = 12;
  static double textFieldFontSize = 16;

  // ----------------------------------- styles for (texts) -----------------------------------

  static TextStyle titleStyle = TextStyle(color:titleColor,fontSize:titleFontSize,fontWeight: FontWeight.bold);
  static TextStyle subTitleStyle = TextStyle(color:subTitleColor,fontSize:subtitleFontSize,fontWeight: FontWeight.bold);
  static TextStyle textKeyStyle = TextStyle(color:textKeyColor,fontSize:textKeyFontSize,fontWeight: FontWeight.bold);
  static TextStyle textValueStyle = TextStyle(color:textValueColor,fontSize:textValueFontSize,fontWeight: FontWeight.bold);
  static TextStyle textValuekglbsStyle_non_selected = TextStyle(color:textValueColor,fontSize:textValueFontSize);
  static TextStyle textValuekglbsStyle_selected = TextStyle(color:textValueColor,fontSize:textValueFontSize,fontWeight: FontWeight.bold);
  static TextStyle textButtonStyle = TextStyle(color:buttonTextColor,fontSize:buttonTextFontSize,fontWeight: FontWeight.bold);
  static TextStyle textHyperlinkStyle = TextStyle(color:hyperLinkTextColor,fontSize:hyperLinkTextFontSize,fontWeight: FontWeight.bold);
  static TextStyle textavatarStyle = TextStyle(color:avatarTextColor,fontSize:avatarTextFontSize,fontWeight: FontWeight.bold);
  static TextStyle texthypertextStyle = TextStyle(color:hyperTextColor,fontSize:hyperTextFontSize);
  static TextStyle textfieldStyle = TextStyle(color:textFieldColor,fontSize:textFieldFontSize);
  static TextStyle textfieldHintTextStyle = TextStyle(color:textFieldTextHintColor,fontSize:textFieldFontSize);
  static TextStyle textCardTextStyle = TextStyle(color:cardTextColor,fontSize:cardTextFontSize,fontWeight: FontWeight.bold);
  static TextStyle textchartBarTextStyle = TextStyle(color:chartBarTextColor,fontSize:chartBarTextFontSize,fontWeight: FontWeight.bold);
  
}