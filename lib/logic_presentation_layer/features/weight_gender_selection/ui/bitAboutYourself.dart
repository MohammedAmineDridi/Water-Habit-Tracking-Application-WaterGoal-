import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/logic_presentation_layer/features/weight_gender_selection/bloc/user_info_bloc.dart';
import 'package:watergoal/logic_presentation_layer/features/weight_gender_selection/data/userInfoData.dart';
import '../../../widgets/reusableWidgets.dart';
import '../../../themes/appStyles.dart';
import '../../../widgets/curvedLine.dart';
import '../../../../core/helpers/helpers.dart';

TextEditingController weightController = TextEditingController();
String savedSelectedGender = "";
String savedSelectedWeightUnit = "";

class UserInfo extends StatelessWidget {

  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserInfoBloc>(
      create: (context) => UserInfoBloc(),
      child:Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.only(top:80,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 10),
      child:Column(
      children: [
        Reusablewidgets(context).customTitle("A bit about yourself",20,20),
        SizedBox(height: 40),
        Container(alignment:Alignment.center ,child:Text("Gender",style:AppStyles.subTitleStyle)),
        SizedBox(height: 40),
        
        BlocBuilder<UserInfoBloc,UserInfoState>(
          builder: (context,state) {
          if (state is UserInfoInitial){
            return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child: Image.asset(AppStyles.imageFemaleAvatar_non_selected),
              )
              ),
              Text("female",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : female");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "female"));
            }),
            SizedBox(width: 80),
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child: Image.asset(AppStyles.imageMaleAvatar_non_selected),
              )
              ),
              Text("male",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : male");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "male"));
            })
            ]);
            }
            
            if (state is GenderChangedValue){
            savedSelectedGender = state.gender;
            return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child: (state.gender == "male") ? Image.asset(AppStyles.imageFemaleAvatar_non_selected) : Image.asset(AppStyles.imageFemaleAvatar_selected),
              )
              ),
              Text("female",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : female");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "female"));
            }),
            SizedBox(width: 80),
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child:  (state.gender == "female") ?  Image.asset(AppStyles.imageMaleAvatar_non_selected) : Image.asset(AppStyles.imageMaleAvatar_selected),
              )
              ),
              Text("male",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : male");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "male"));
            })
            ]);
            }
            return (savedSelectedGender.isNotEmpty) ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child: (savedSelectedGender == "male") ? Image.asset(AppStyles.imageFemaleAvatar_non_selected) : Image.asset(AppStyles.imageFemaleAvatar_selected),
              )
              ),
              Text("female",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : female");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "female"));
            }),
            SizedBox(width: 80),
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child:  (savedSelectedGender == "female") ?  Image.asset(AppStyles.imageMaleAvatar_non_selected) : Image.asset(AppStyles.imageMaleAvatar_selected),
              )
              ),
              Text("male",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : male");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "male"));
            })
            ]) : 
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child: Image.asset(AppStyles.imageFemaleAvatar_non_selected),
              )
              ),
              Text("female",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : female");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "female"));
            }),
            SizedBox(width: 80),
            GestureDetector(child:Column(children: [
              Container(child:CircleAvatar(
              radius: 40,
              child: Image.asset(AppStyles.imageMaleAvatar_non_selected),
              )
              ),
              Text("male",style:AppStyles.textavatarStyle)
            ]),onTap: (){
                print("gender selected : male");
                BlocProvider.of<UserInfoBloc>(context).add(SelectGenderEventUserInfo(selectedGender: "male"));
            })
            ]);
            }
            ),
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
        Container(alignment:Alignment.center ,child:Text("Weight",style:AppStyles.subTitleStyle)),
        SizedBox(height: 40),
        BlocBuilder<UserInfoBloc,UserInfoState>(
          builder: (context,state){
            if (state is UserInfoInitial) {
                return Container(
                margin: EdgeInsets.only(left:40,right:40),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                Expanded(child: Reusablewidgets(context).lineTextField(weightController, 4, (newWeightValue){
                    print("new WeightValue = "+newWeightValue);
                })
                ),
                TextButton(child:Text("Kg",style: AppStyles.textValuekglbsStyle_non_selected),onPressed: (){
                  print("unit selected : Kg");
                  BlocProvider.of<UserInfoBloc>(context).add(SelectWeightUnitEventUserInfo(weightUnit: "Kg"));
                }),
                Text("/",style: AppStyles.textValueStyle),
                TextButton(child:Text("Lbs",style: AppStyles.textValuekglbsStyle_non_selected),onPressed: (){
                  print("unit selected : Lbs");
                  BlocProvider.of<UserInfoBloc>(context).add(SelectWeightUnitEventUserInfo(weightUnit: "Lbs"));
                })
                ],
                )
                );
            }
            if (state is WeightUnitChangedValue){
               savedSelectedWeightUnit = state.weightUnit;
               print("========== weight unit selected = "+state.weightUnit);
                return Container(
                margin: EdgeInsets.only(left:40,right:40),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                Expanded(child: Reusablewidgets(context).lineTextField(weightController, 4, (newWeightValue){
                    print("new WeightValue = "+newWeightValue);
                })
                ),
                TextButton(child: (state.weightUnit == "Kg") ?Text("Kg",style: AppStyles.textValuekglbsStyle_selected):Text("Kg",style: AppStyles.textValuekglbsStyle_non_selected),onPressed: (){
                  print("unit selected : Kg");
                  BlocProvider.of<UserInfoBloc>(context).add(SelectWeightUnitEventUserInfo(weightUnit: "Kg"));
                }),
                Text("/",style: AppStyles.textValueStyle),
                TextButton(child: (state.weightUnit == "Lbs") ? Text("Lbs",style: AppStyles.textValuekglbsStyle_selected) : Text("Lbs",style: AppStyles.textValuekglbsStyle_non_selected),onPressed: (){
                  print("unit selected : Lbs");
                  BlocProvider.of<UserInfoBloc>(context).add(SelectWeightUnitEventUserInfo(weightUnit: "Lbs"));
                })
                ],
                )
                );
            }
            return  Container(
                margin: EdgeInsets.only(left:40,right:40),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                Expanded(child: Reusablewidgets(context).lineTextField(weightController, 4, (newWeightValue){
                    print("new WeightValue = "+newWeightValue);
                })
                ),
                TextButton(child: (savedSelectedWeightUnit == "Kg") ?Text("Kg",style: AppStyles.textValuekglbsStyle_selected):Text("Kg",style: AppStyles.textValuekglbsStyle_non_selected),onPressed: (){
                  print("unit selected : Kg");
                  BlocProvider.of<UserInfoBloc>(context).add(SelectWeightUnitEventUserInfo(weightUnit: "Kg"));
                }),
                Text("/",style: AppStyles.textValueStyle),
                TextButton(child: (savedSelectedGender == "Lbs") ? Text("Lbs",style: AppStyles.textValuekglbsStyle_selected) : Text("Lbs",style: AppStyles.textValuekglbsStyle_non_selected),onPressed: (){
                  print("unit selected : Lbs");
                  BlocProvider.of<UserInfoBloc>(context).add(SelectWeightUnitEventUserInfo(weightUnit: "Lbs")); 
                })
                ],
                )
                );
          }
        ),
        SizedBox(height: 40),
        Container(alignment:Alignment.center,
        child:Reusablewidgets(context).mainButton("Next 1/3    👉", 20,EdgeInsets.only(right:60,left:60,top:10,bottom: 10),()async {
            print("button next 1/3 is pressed");
            int userId = await getSharedprefuserId("user_id");
            print("update to user_id = "+ userId.toString()+": gender = "+savedSelectedGender+" / weight unit = "+savedSelectedWeightUnit+" / weight value = "+weightController.text);
            print("WEIGHT GENDER : "+userRepository.getUserById(userId).toString());
            updateUserById_Weight_Gender(userId, weightController.text+" "+savedSelectedWeightUnit, savedSelectedGender);
            goTo(context, "dailyGoal");
        }),
        )
      ],
    ))
    )
    )
    );
  }
}