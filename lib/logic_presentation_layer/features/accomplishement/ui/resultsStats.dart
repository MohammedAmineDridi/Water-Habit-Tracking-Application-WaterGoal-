import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/data_layer/models/accomplishement.dart';
import 'package:watergoal/logic_presentation_layer/features/accomplishement/bloc/accomplishement_bloc.dart';
import '../../../widgets/reusableWidgets.dart';
import '../../../widgets/pdf.dart';
import '../../../themes/appStyles.dart';
import '../../../widgets/chart.dart';
import '../.././../../core/helpers/helpers.dart';
import '../../../../data_layer/models/user.dart';
import '../data/accomplishementData.dart';

  String savedStartDate = "";
  String savedEndDate = "";
  int savedAveragePercentage = 0;
  List<Accomplishement> savedListAccomplishements = [];
  User? user;

  final TextEditingController startdateController = TextEditingController();
  final TextEditingController enddateController = TextEditingController();

   Future<DateTime> _selectDate(BuildContext context,String type) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      if (type == "from"){
        print("selected start date is : "+pickedDate.toString());
        
      } else if (type == "to"){
        print("selected end date is : "+pickedDate.toString());
      }
    }
    return pickedDate!;
  }

class ResultStats extends StatelessWidget {

  ResultStats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccomplishementBloc>(
      create: (context) => AccomplishementBloc(),
      child: Scaffold(
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
        Container(
        margin: EdgeInsets.only(right:40,left:40),
        alignment:Alignment.center ,child:Text("Accomplishement",style:AppStyles.titleStyle),
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1),borderRadius: BorderRadius.circular(50))
        ),
        SizedBox(height: 40),
        // filter by (date : start / end)
        Container(
          margin: EdgeInsets.only(right:40,left:40),
          child:Column(children: [
            // row 1 : from
            Row(children: [
              Text("From :",style:AppStyles.textValueStyle),
              SizedBox(width: 10),
              BlocBuilder<AccomplishementBloc,AccomplishementState>(
              builder: (context,state) {
              if (state is AccomplishementInitial){
                return Container(
                width: 200,
                child:Reusablewidgets(context).regularTextField(
                startdateController,
                "pick start date",
                Icons.date_range_outlined,
                type: "date",
                onPressedIcon: ()async {
                  String selectedStartDate = dateChangeFormat(await _selectDate(context,"from"));
                  savedStartDate = selectedStartDate;
                  BlocProvider.of<AccomplishementBloc>(context).add(SelectStartDate(startDate: selectedStartDate));
                  if (savedEndDate != "" && savedStartDate != ""){
                      print("send event to update the chart & average value with dates : start = "+savedStartDate+" / end : "+savedEndDate);
                      int userId = await getSharedprefuserId("user_id");
                      List<Accomplishement> accomplishements = await getAccomplishementByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(SelectDateFiltredStats(accomplishements: accomplishements));  
                      int averagePercentage = await getAccomplishementAverageByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(TriggerAveragePercentage(averagePercentage: averagePercentage));
                  }
                }));
              }
              if (state is StartDateIsSelected){
                // save start date here ..
                return Container(
                width: 200,
                child:Reusablewidgets(context).regularTextField(
                startdateController,
                state.startDateSelected,
                Icons.date_range_outlined, 
                type: "date",
                onPressedIcon: ()async {
                  String selectedStartDate = dateChangeFormat(await _selectDate(context,"from"));
                  savedStartDate = selectedStartDate;
                  BlocProvider.of<AccomplishementBloc>(context).add(SelectStartDate(startDate: startdateController.text));
                  if (savedEndDate != "" && savedStartDate != ""){
                      print("send event to update the chart & average value with dates : start = "+savedStartDate+" / end : "+savedEndDate);
                      int userId = await getSharedprefuserId("user_id");
                      List<Accomplishement> accomplishements = await getAccomplishementByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(SelectDateFiltredStats(accomplishements: accomplishements));
                      int averagePercentage = await getAccomplishementAverageByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(TriggerAveragePercentage(averagePercentage: averagePercentage));
                  }
                }));
              }
              return Container(
                width: 200,
                child:Reusablewidgets(context).regularTextField(
                startdateController,
                (savedStartDate != "")?savedStartDate:"pick start date",
                Icons.date_range_outlined,
                type: "date",
                onPressedIcon: ()async {
                  String selectedStartDate = dateChangeFormat(await _selectDate(context,"from"));
                  savedStartDate = selectedStartDate;
                  BlocProvider.of<AccomplishementBloc>(context).add(SelectStartDate(startDate: selectedStartDate));
                  if (savedEndDate != "" && savedStartDate != ""){
                      print("send event to update the chart & average value with dates : start = "+savedStartDate+" / end : "+savedEndDate);
                      int userId = await getSharedprefuserId("user_id");
                      List<Accomplishement> accomplishements = await getAccomplishementByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(SelectDateFiltredStats(accomplishements: accomplishements));
                      int averagePercentage = await getAccomplishementAverageByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(TriggerAveragePercentage(averagePercentage: averagePercentage));
                  }
                }));
              }),

            ]),
            SizedBox(height: 20),
            // row 2 : to
            Row(children: [
              Text("To :",style:AppStyles.textValueStyle),
              SizedBox(width:28),
              BlocBuilder<AccomplishementBloc,AccomplishementState>(
              builder: (context,state) {
              if (state is AccomplishementInitial){
                return Container(
                width: 200,
                child:Reusablewidgets(context).regularTextField(
                startdateController,
                "pick end date",
                Icons.date_range_outlined,
                type: "date",
                onPressedIcon: ()async {
                  String selectedEndDate = dateChangeFormat(await _selectDate(context,"to"));
                  savedEndDate = selectedEndDate;
                  BlocProvider.of<AccomplishementBloc>(context).add(SelectEndDate(endDate: selectedEndDate));
                  if (savedEndDate != "" && savedStartDate != ""){
                      print("send event to update the chart & average value with dates : start = "+savedStartDate+" / end : "+savedEndDate);
                      int userId = await getSharedprefuserId("user_id");
                      List<Accomplishement> accomplishements = await getAccomplishementByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(SelectDateFiltredStats(accomplishements: accomplishements));
                      int averagePercentage = await getAccomplishementAverageByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(TriggerAveragePercentage(averagePercentage: averagePercentage));
                  }
                  
                }));
              }
              if (state is EndDateIsSelected){
                // save start date here ..
                return Container(
                width: 200,
                child:Reusablewidgets(context).regularTextField(
                enddateController,
                state.endDateSelected,
                Icons.date_range_outlined, 
                type: "date",
                onPressedIcon: ()async{
                  _selectDate(context,"to");
                  String selectedEndDate = dateChangeFormat(await _selectDate(context,"to"));
                  savedEndDate = selectedEndDate;
                  BlocProvider.of<AccomplishementBloc>(context).add(SelectEndDate(endDate: enddateController.text));
                  if (savedEndDate != "" && savedStartDate != ""){
                      print("send event to update the chart & average value with dates : start = "+savedStartDate+" / end : "+savedEndDate);
                      int userId = await getSharedprefuserId("user_id");
                      List<Accomplishement> accomplishements = await getAccomplishementByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(SelectDateFiltredStats(accomplishements: accomplishements));
                      int averagePercentage = await getAccomplishementAverageByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(TriggerAveragePercentage(averagePercentage: averagePercentage));
                  }
                }));
              }
              return Container(
                width: 200,
                child:Reusablewidgets(context).regularTextField(
                enddateController,
                (savedEndDate != "")?savedEndDate:"pick end date",
                Icons.date_range_outlined,
                type: "date",
                onPressedIcon: ()async {
                  String selectedEndDate = dateChangeFormat(await _selectDate(context,"to"));
                  savedEndDate = selectedEndDate;
                  BlocProvider.of<AccomplishementBloc>(context).add(SelectEndDate(endDate: selectedEndDate));
                  if (savedEndDate != "" && savedStartDate != ""){
                      print("send event to update the chart & average value with dates : start = "+savedStartDate+" / end : "+savedEndDate);
                      int userId = await getSharedprefuserId("user_id");
                      List<Accomplishement> accomplishements = await getAccomplishementByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(SelectDateFiltredStats(accomplishements: accomplishements));
                      int averagePercentage = await getAccomplishementAverageByuserIdBetweenDatesData(userId,savedStartDate,savedEndDate);
                      BlocProvider.of<AccomplishementBloc>(context).add(TriggerAveragePercentage(averagePercentage: averagePercentage));
                  }
                }));
              }),
            ]),
          ])
        ),
        // stats are : (2 stats per 1 row)
        // stat 1 (Daily Water Intake Graph) : barchart water drink percentage per day
        // stat 2 : (Average Daily Intake percentage) : a card that contain a number (Average Daily Intake percentage) 
        SizedBox(height:20),
        Container(alignment:Alignment.center ,child:Text("Water drinking percentage per period",style:AppStyles.textValueStyle)),
        SizedBox(height:20),
        
        BlocBuilder<AccomplishementBloc,AccomplishementState>(
        builder: (context,state) {
        if (state is AccomplishementInitial){
        print("éna hné tawa 1");
        return SizedBox();
        }
        if (state is ReceiveDateFiltredStats){
              savedListAccomplishements = state.accomplishements;
              print(" éna hné tawa 2 : list of accomps : "+state.accomplishements.toString());
              return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Container(
              height: 180,
              width: 600,
              child:AspectRatio(
                aspectRatio: 16 / 9,
                child: AspectRatio(
                aspectRatio: 16 / 9,
                  child: Chart().createCustomChartBars(state.accomplishements)
              )
              )));
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Container(
              height: 180,
              width: 600,
              child:AspectRatio(
              aspectRatio: 16 / 9,
              child: AspectRatio(
              aspectRatio: 16 / 9,
                child: Chart().createCustomChartBars(savedListAccomplishements)
                ))));
        }),

        // col 3 : digital card contain value (Average Daily Intake percentage)
        SizedBox(height:20),
        Container(
          margin: EdgeInsets.only(left: 40,right:40),
          child:Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: AppStyles.cardColor),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              BlocBuilder<AccomplishementBloc,AccomplishementState>(
              builder: (context,state) {
              if (state is AccomplishementInitial) {
               return FutureBuilder<dynamic>(
                  future: getSharedprefuserId("user_id"),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    int user_id = snapshot.data;
                    return FutureBuilder<int>(
                      future: getAccomplishementAverageByuserIdBetweenDatesData(user_id,getDateSevenDaysAgoStringFormat(),getCurrentDateStringFormat()),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        int averagePercentage = snapshot.data;
                        return Text("Average percentage : "+averagePercentage.toInt().toString()+"%",style:AppStyles.textCardTextStyle);
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    });
                  } else {
                    return Center(child: Text('No data available'));
                  }
                });
              }
              if (state is AverageIsTriggered){
                savedAveragePercentage = state.averagePercentage;
                return Text("Average percentage : "+savedAveragePercentage.toInt().toString()+"%",style:AppStyles.textCardTextStyle);
              }
              return Text("Average percentage : "+savedAveragePercentage.toInt().toString()+"%",style:AppStyles.textCardTextStyle);
              }
              )
            ])
          )
        ),
        SizedBox(height:20),
        //export report PDF
        Container(alignment:Alignment.center,
        margin: EdgeInsets.only(left:40,right:40),
        child:Reusablewidgets(context).mainButton("Export PDF Report", 20, EdgeInsets.only(right:30,left:30,top:10,bottom: 10),()async {  
            int userId = await getSharedprefuserId("user_id");
            User? user = await getUserByIdAccData(userId);
            Pdf().createPdf(savedListAccomplishements,getCurrentDateStringFormat(),user!.username!,AppStyles.logoWaterGoal,"Water drinking percentages report");
        }
        )
        ),
      ],
    ))
      )
      )
    );
  }
}


