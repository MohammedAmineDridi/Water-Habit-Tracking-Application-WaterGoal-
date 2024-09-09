import 'package:flutter/material.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/logic_presentation_layer/widgets/reusableWidgets.dart';
import '../../../themes/appStyles.dart';
import '../../../../data_layer/models/user.dart';

class ProfileSettings extends StatelessWidget {

  final User user;
  const ProfileSettings({super.key , required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
      child:Container(
      margin: EdgeInsets.only(top:60,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 10),
      child:Column(
      children: [
        Reusablewidgets(context).IconPressed( Icons.arrow_back_ios_rounded , (){
          print("arrow icon pressed");
          goTo(context,"stayHydrated");
        }),
        Reusablewidgets(context).customTitle("Hi, "+user.username.toString(),100,100),
        SizedBox(height: 40),
        Container(alignment:Alignment.center ,child:Text("Profile",style:AppStyles.subTitleStyle)),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(right:20,left:20),
          child:Column(children:[
            Row(children:[  
              Text("Gender",style:AppStyles.textKeyStyle),
              Spacer(),
              Text(user.gender.toString(),style:AppStyles.textValueStyle)
            ]),
            Row(children:[
              Text("Weight",style:AppStyles.textKeyStyle),
              Spacer(),
              Text(user.weight.toString(),style:AppStyles.textValueStyle)
            ]),
          ])
        ),
        SizedBox(height:40),
        Container(alignment:Alignment.center ,child:Text("Settings",style:AppStyles.subTitleStyle)),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(right:20,left:20),
          child:Column(children:[
            Row(children:[  
              Text("Daily goal",style:AppStyles.textKeyStyle),
              Spacer(),
              Text(user.waterGoalPercentage.toString(),style:AppStyles.textValueStyle)
            ]),
            Row(children:[
              Text("Accomplishement",style:AppStyles.textKeyStyle),
              Spacer(),
              Text(user.currentWaterPercentage.toString()+" %",style:AppStyles.textValueStyle)
            ]),
          ])
        ),
        SizedBox(height:40),
        Container(alignment:Alignment.center ,child:Text("Credit",style:AppStyles.subTitleStyle)),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(right:20,left:20),
          child:Column(children:[
            Text("Design & programming by : ",style:AppStyles.textValueStyle),
            Text("Dridi Mohammed Amine",style:AppStyles.textValueStyle)
          ])
        ),
        SizedBox(height:40),
        Reusablewidgets(context).hyperLinkNavigation("Log out", (){
          print("Log out is pressed");
          goTo(context,"getStarted");
        })
      ],
    ))));
  }
}