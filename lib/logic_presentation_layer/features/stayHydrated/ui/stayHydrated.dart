import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/logic_presentation_layer/features/stayHydrated/bloc/stayhydrated_bloc.dart';
import 'package:watergoal/logic_presentation_layer/widgets/reusableWidgets.dart';
import '../../../widgets/bottle.dart';
import '../../../themes/appStyles.dart';
import '../data/stayHydratedData.dart';
import '../../../../data_layer/models/user.dart';
import '../../../../core/helpers/helpers.dart';

int savedCurrentCompletedValue = 0;

int savedPercentage = 0;

class StayHydrated extends StatelessWidget {

  const StayHydrated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StayhydratedBloc>(
      create: (context) => StayhydratedBloc(),
      child:Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.only(top:60,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 10),
      child:Column(
      children: [
        Row(children: [
        Reusablewidgets(context).IconPressed( Icons.arrow_back_ios_rounded,(){
          print("arrow icon pressed");
          goTo(context,"dailyGoal");
        }),
        Spacer(),
        Container(alignment: Alignment.centerLeft,
        child:Reusablewidgets(context).IconPressed( Icons.settings,() async{
          print("settings icon pressed");
          int userId = await getSharedprefuserId("user_id");
          User? user = await getUserByIdData(userId);
          goTo(context,"profileSettings",arguments: user);
        }),
        ) ,
        Container(alignment: Alignment.centerLeft,
        child:Reusablewidgets(context).IconPressed( Icons.bar_chart_rounded,(){
          print("stats icon pressed");
          goTo(context,"resultStats");
        }),
        ) ,
        ]),
        Reusablewidgets(context).customTitle("Stay Hydrated",60,60),
        SizedBox(height: 80),
        
      FutureBuilder<dynamic>(
      future:getSharedprefuserId("user_id"),
      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          int userId = int.parse(snapshot.data.toString());
          return FutureBuilder<User?>(
          future: getUserByIdData( userId ),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              User? user = snapshot.data;
            user!.currentWaterPercentage != null ? savedCurrentCompletedValue = user.currentWaterPercentage! : savedCurrentCompletedValue = 0;
              
                return Container(
                  margin:EdgeInsets.only(right:60,left:60),
                  child: Column(children: [
                  Row( children: [
                      Container(
                      child:Text("Goal :",style:AppStyles.textKeyStyle),
                      ),
                      SizedBox(width: 10),
                      Container(child:Text(user.waterGoalPercentage!.toString(),style:AppStyles.textValueStyle)
                      )
                  ]
                  ),
                  SizedBox(height:20),
                  Row( children: [
                      Container(
                      child:Text("Completed :",style:AppStyles.textKeyStyle),
                      ),
                      SizedBox(width: 10),
                      BlocBuilder<StayhydratedBloc,StayhydratedState>(builder: (context,state){
                        if (state is StayhydratedInitial){
                            return Container(child:Text( (user.currentWaterPercentage == null) ? "0 %" : user.currentWaterPercentage.toString()+" %" ,style:AppStyles.textValueStyle));
                        }
                        if (state is PercentageIsChangedState){
                          return Container(child:Text( user.currentWaterPercentage.toString()+" %",style:AppStyles.textValueStyle));
                        }
                        if (state is PercentageCompletedTextChangedState){
                          return Container(child:Text( state.waterpercentage.toInt().toString()+" %" ,style:AppStyles.textValueStyle));
                        }
                        return SizedBox();
                      })
                  ]
                  ),
                  ])
              );
            }
            else {
              return Center(child: Text('user data is not available 1'));
            }
          }
          );
        }
        else {
          return Center(child: Text('user data is not available 2'));
        }
      }
      ),
      

        SizedBox(height:80),
        BlocBuilder<StayhydratedBloc,StayhydratedState>(
          builder: (context,state) {
            if (state is StayhydratedInitial){
                    return Container(
                    margin: EdgeInsets.only(left:60,right:60),
                    child:Row(children: [
                    SliderTheme(
                    data: SliderThemeData(
                    trackHeight: 8.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    thumbColor: AppStyles.sliderSlidingColor,
                    activeTrackColor: AppStyles.sliderSlidingColor,
                    inactiveTrackColor: AppStyles.sliderSlidingColor,
                    overlayColor: AppStyles.sliderSlidingColor,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                        margin: EdgeInsets.only(left:18),
                        child:Text(savedCurrentCompletedValue.toInt().toString()+" %",style:AppStyles.textValueStyle)
                        ),
                        RotatedBox(quarterTurns: 3,
                        child:Slider(
                          activeColor: Color(0xFF00008B),
                          inactiveColor: AppStyles.sliderEmptyBarColor,
                          thumbColor: AppStyles.sliderSlidingColor,
                          value: savedCurrentCompletedValue.toDouble(),
                          min: 0,
                          max: 100,
                          onChanged: (newvalue) {
                            print("new value is = "+newvalue.toString());
                            BlocProvider.of<StayhydratedBloc>(context).add(PercentageUpdateEvent(waterpercentage: newvalue.toDouble()));
                          },
                          onChangeEnd: (newvalue) {
                            Reusablewidgets(context).showCustomPopup(context,"Comfirm new percentage","Are your sure to comfirm this new a value : "+savedCurrentCompletedValue.toInt().toString()+" % ?","Yes","No",onYesPressed: () async {
                              int userId = await getSharedprefuserId("user_id");
                              savedCurrentCompletedValue = newvalue.toInt();
                              updateCurrentWaterPercentage(userId, savedCurrentCompletedValue.toInt());
                              print("update to user_id = "+userId.toString()+" / daily goal percentage = "+savedCurrentCompletedValue.toString());
                              BlocProvider.of<StayhydratedBloc>(context).add(UpdatePercentageCompleted(waterpercentage: newvalue.toDouble()));
                              Navigator.of(context).pop();
                            });

                          },
                        )
                        )
                      ],
                    )
                    ),
                    SizedBox(width: 30),
                    CustomPaint(
                      size: Size(100, 180), // Adjust the size as needed (width,height)
                      painter: BottlePainter(waterLevel: savedCurrentCompletedValue/100), // 0 (0 %) to 1 (100%)
                    ),
                  ]
                  ));
            }
            if (state is PercentageIsChangedState){
              savedPercentage = state.waterpercentage.toInt();
              return Container(
                    margin: EdgeInsets.only(left:60,right:60),
                    child:Row(children: [
                    SliderTheme(
                    data: SliderThemeData(
                    trackHeight: 8.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    thumbColor: AppStyles.sliderSlidingColor,
                    activeTrackColor: AppStyles.sliderSlidingColor,
                    inactiveTrackColor: AppStyles.sliderSlidingColor,
                    overlayColor: AppStyles.sliderSlidingColor,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                        margin: EdgeInsets.only(left:18),
                        child:Text(state.waterpercentage.toInt().toString()+" %",style:AppStyles.textValueStyle)
                        ),
                        RotatedBox(quarterTurns: 3,
                        child:Slider(
                          activeColor: Color(0xFF00008B),
                          inactiveColor: AppStyles.sliderEmptyBarColor, 
                          thumbColor: AppStyles.sliderSlidingColor,
                          value: state.waterpercentage,
                          min: 0,
                          max: 100,
                          onChanged: (newvalue) {
                            print("new value is = "+newvalue.toString());
                            BlocProvider.of<StayhydratedBloc>(context).add(PercentageUpdateEvent(waterpercentage: newvalue.toDouble()));
                          },
                          onChangeEnd: (newvalue) {
                            Reusablewidgets(context).showCustomPopup(context,"Comfirm new percentage","Are your sure to comfirm this new water percentage value : "+state.waterpercentage.toInt().toString()+" % ?","Yes","No",onYesPressed: () async {
                              int userId = await getSharedprefuserId("user_id");
                              updateCurrentWaterPercentage(userId, state.waterpercentage.toInt());
                              BlocProvider.of<StayhydratedBloc>(context).add(UpdatePercentageCompleted(waterpercentage: newvalue.toDouble()));
                              savedCurrentCompletedValue = newvalue.toInt();
                              Navigator.of(context).pop();
                            });
                            
                          },
                        )
                        )
                      ],
                    )
                    ),
                    SizedBox(width: 30),
                    // the water bottle
                    CustomPaint(
                      size: Size(100, 180), // Adjust the size as needed (width,height)
                      painter: BottlePainter(waterLevel: state.waterpercentage/100), // 0 (0 %) to 1 (100%)
                    ),
                  ]
                  ));

            }
            return savedPercentage != 0 ? Container(
                    margin: EdgeInsets.only(left:60,right:60),
                    child:Row(children: [
                    SliderTheme(
                    data: SliderThemeData(
                    trackHeight: 8.0, 
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    thumbColor: AppStyles.sliderSlidingColor,
                    activeTrackColor: AppStyles.sliderSlidingColor,
                    inactiveTrackColor: AppStyles.sliderSlidingColor,
                    overlayColor: AppStyles.sliderSlidingColor,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                        margin: EdgeInsets.only(left:18),
                        child:Text(savedPercentage.toInt().toString()+" %",style:AppStyles.textValueStyle)
                        ),
                        RotatedBox(quarterTurns: 3,
                        child:Slider(
                          activeColor: Color(0xFF00008B),
                          inactiveColor: AppStyles.sliderEmptyBarColor,
                          thumbColor: AppStyles.sliderSlidingColor,
                          value: savedPercentage.toDouble(),
                          min: 0,
                          max: 100,
                          onChanged: (newvalue) {
                            print("new value is = "+newvalue.toString());
                            BlocProvider.of<StayhydratedBloc>(context).add(PercentageUpdateEvent(waterpercentage: newvalue.toDouble()));
                          },
                          onChangeEnd: (newvalue) {
                            Reusablewidgets(context).showCustomPopup(context,"Comfirm new percentage","Are your sure to comfirm this new water percentage value : "+savedPercentage.toInt().toString()+" % ?","Yes","No",onYesPressed: () async {
                              int userId = await getSharedprefuserId("user_id");
                              updateCurrentWaterPercentage(userId, savedCurrentCompletedValue.toInt());
                              BlocProvider.of<StayhydratedBloc>(context).add(UpdatePercentageCompleted(waterpercentage: newvalue.toDouble()));
                              Navigator.of(context).pop();
                            });
                          },
                        )
                        )
                      ],
                    )
                    ),
                    SizedBox(width: 30),
                    // the water bottle
                    CustomPaint(
                      size: Size(100, 180), // Adjust the size as needed (width,height)
                      painter: BottlePainter(waterLevel: savedPercentage/100), // 0 (0 %) to 1 (100%)
                    ),
                  ]
                  )) : SizedBox();
          }
        )
      ],
    )
    )
    )
    )
    );
  }
}