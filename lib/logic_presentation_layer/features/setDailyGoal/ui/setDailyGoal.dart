import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/data_layer/repos/userRepository.dart';
import 'package:watergoal/logic_presentation_layer/features/setDailyGoal/bloc/dailygoal_bloc.dart';
import 'package:watergoal/logic_presentation_layer/features/setDailyGoal/data/setDailyGoaldData.dart';
import 'package:watergoal/logic_presentation_layer/widgets/reusableWidgets.dart';
import '../../../themes/appStyles.dart';
import '../../../widgets/curvedLine.dart';
import '../../../../core/helpers/helpers.dart';

TextEditingController dailygoalController = TextEditingController();
String savedSelectedGoalUnit = "";

class SetDailyGoal extends StatelessWidget {

  const SetDailyGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailygoalBloc>(
      create: (context) => DailygoalBloc(),
      child:Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
      child:Container(
      margin: EdgeInsets.only(top:60,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 10),
      child:Column(
      children: [
        Reusablewidgets(context).IconPressed( Icons.arrow_back_ios_rounded, (){
          print("arrow icon pressed");
          goTo(context, "userInfo");
        }),
        Reusablewidgets(context).customTitle("Set daily goal",60,60),
        SizedBox(height: 40),
        Container(alignment:Alignment.center ,child:Text("Unit of measurement",style:AppStyles.subTitleStyle)),
        SizedBox(height: 40),
        BlocBuilder<DailygoalBloc,DailygoalState>(
          builder: (context,state) {
          if (state is DailygoalInitial){
            return  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            GestureDetector(child:Column(children: [
              Container(
              margin:EdgeInsets.only(left: 10),
              child:Image.asset('assets/images/page5_set_daily_goal/milliliter_non_selected.gif',scale: 4.0),
              ),
              Text("milliliter",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("unit selected : millimeter (mL)");
                BlocProvider.of<DailygoalBloc>(context).add(SelectGoaltUnitInfo(unitSelected: "ml"));
            }),
            SizedBox(width: 30),
            GestureDetector(child:Column(children: [
              Container(child:Image.asset('assets/images/page5_set_daily_goal/oz_non_selected.gif',scale: 4.0),
              ),
              Text("ounce",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("unit selected : ounce (oz)");
                BlocProvider.of<DailygoalBloc>(context).add(SelectGoaltUnitInfo(unitSelected: "oz"));
            })
          ]);
          }
          if (state is GoalUnitChangedValue){
          savedSelectedGoalUnit = state.unitSelected;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            GestureDetector(child:Column(children: [
              Container(
              margin:EdgeInsets.only(left: 10),
              child:(state.unitSelected == "ml") ? Image.asset(AppStyles.millimeter_selected,scale: 4.0):Image.asset(AppStyles.millimeter_non_selected,scale: 4.0),
              ),
              Text("milliliter",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("unit selected : millimeter (mL)");
                BlocProvider.of<DailygoalBloc>(context).add(SelectGoaltUnitInfo(unitSelected: "ml"));
            }),
            SizedBox(width: 30),
            GestureDetector(child:Column(children: [
              Container(child:(state.unitSelected == "oz") ? Image.asset(AppStyles.ounce_selected,scale: 4.0):Image.asset(AppStyles.ounce_non_selected,scale: 4.0),
              ),
              Text("ounce",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("unit selected : ounce (oz)");
                BlocProvider.of<DailygoalBloc>(context).add(SelectGoaltUnitInfo(unitSelected: "oz"));
            })
            ]);
          }
          return SizedBox();
          }),
        SizedBox(height: 40),
        Center(
          child: Container(
            width: 250,
            height: 30,
            child: CustomPaint(
              painter: CurvedLinePainter(),
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(alignment:Alignment.center ,child:Text("Daily Goal",style:AppStyles.subTitleStyle)),
        SizedBox(height: 40),
        Container(
        margin: EdgeInsets.only(left:100,right:100),
        child: Reusablewidgets(context).lineTextField(dailygoalController, 4, (newGoalValue){
            print("new Goal Value = "+newGoalValue);
        })
        ),
        SizedBox(height: 40),
        Container(alignment:Alignment.center,
        child:MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.blue,
        child: Padding(padding:EdgeInsets.only(right:60,left:60,top:10,bottom: 10) ,child:Text("Next 2/3    👉",style: TextStyle(color: Colors.white,fontSize: 16))),
        onPressed: () async {
            print("next 2/3 btn is clicked");
            int userId = await getSharedprefuserId("user_id");
            print("update to user_id = "+ userId.toString()+": dailygoal Unit = "+savedSelectedGoalUnit+" / dailygoal value = "+dailygoalController.text);
            print("DAILY GOAL : "+new UserRepository().getUserById(userId).toString());
            updateUserDailyGoalData(userId,dailygoalController.text+" "+savedSelectedGoalUnit);
            goTo(context, "stayHydrated");
        })
        )
      ],
    ))
      ))
  );
  }
}
