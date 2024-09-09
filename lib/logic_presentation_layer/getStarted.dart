import 'package:flutter/material.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/logic_presentation_layer/themes/appStyles.dart';
import 'widgets/reusableWidgets.dart';

class Getstarted extends StatelessWidget {

  const Getstarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child:Container(
      margin: EdgeInsets.only(top:60,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 30),
      child:Column(
      children: [
        Container(alignment:Alignment.center ,child:Image.asset(AppStyles.getStartedImage),
        ),
        SizedBox(height: 40),
        Container(alignment:Alignment.center ,child: Text("Your body needs water",style: AppStyles.titleStyle),
        ),
        Container(alignment:Alignment.center ,child: Text("Track your daily water intake with just a few steps",style: AppStyles.texthypertextStyle),
        ),
        SizedBox(height: 20),
        Container(alignment:Alignment.center,
        child:Reusablewidgets(context).mainButton("Get Started", 20,EdgeInsets.only(right:60,left:60,top:10,bottom: 10), (){
          print("Get Started button is pressed");
          goTo(context,"SignUp");
        })
        ),
        SizedBox(height: 20),
        Container(alignment:Alignment.center ,child: Text("Already joined us ?",style: TextStyle(color:AppStyles.hyperTextColor)),
        ),
        Reusablewidgets(context).hyperLinkNavigation("Login here", (){
          print("Login here is pressed");
          goTo(context,"Login");
        })
      ],
    ))
      ),
    );
  }
}
