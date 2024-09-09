import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watergoal/core/helpers/helpers.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/logic_presentation_layer/features/signup/bloc/signup_bloc.dart';
import 'package:watergoal/logic_presentation_layer/widgets/reusableWidgets.dart';
import '../../../themes/appStyles.dart';
import '../../../../data_layer/models/user.dart';
import '../../signup/data/signupData.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../data_layer/models/accomplishement.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool SaveEmailIsvalid = false;
bool SaveVisibility = false;

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

      addAccomplishmentSignUpData(accomplishement);
      print("Accomplishment added: $accomplishement");

      return Future.value(true);
    } catch (e) {
      print("Error in task execution: $e");
      return Future.value(false);
    }
  });
}

void taskLaunching( int frequencyMinute , int initialMinute , int? user_id ) async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // Set to false in production
  );
  int currentpercentageWaterValue = await getPercentageWaterByUserIdData(user_id!);
  print("main : user_id = "+user_id.toString()+" / percantage value = "+currentpercentageWaterValue.toString());

  // Register the background task to run daily at 00:00
  Workmanager().registerPeriodicTask(
    "Add Accomplishement ", // Provide a unique name for the task
    "dailyAccomplishmentTask",
    
    frequency: Duration(hours: 24), // Schedule it to run every 24 hours
    initialDelay: Duration( // initial starting time at 00:00 PM exactly
      hours: 24 - DateTime.now().hour,
      minutes: 60 - DateTime.now().minute,
    ), // Delay to align with midnight
    inputData: {
      'userId': user_id,
      'percentageWaterValue': currentpercentageWaterValue,
      'percentageDate' : getCurrentDateStringFormat()
    },
    ); 
}

class SignUp extends StatelessWidget {

  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(),
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
      //decoration: BoxDecoration(color:Colors.purple),
      margin: EdgeInsets.only(top:60,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 10),
      child:Column(
      children: [
        Reusablewidgets(context).IconPressed( Icons.arrow_back_ios_rounded, (){
          print("arrow icon pressed");
          goTo(context,"getStarted");
        }),
        Reusablewidgets(context).customTitle("Sign Up",100,100),
        SizedBox(height: 10),
        Container(alignment:Alignment.center ,child:Image.asset('assets/images/page2_signup/sign_up.png')),
        SizedBox(height: 10),
        Reusablewidgets(context).regularTextField(
        userNameController,
        "userName",
        Icons.person_outline_outlined,
        onChanged: (newUserName) {
          print("new user name == " + newUserName);
        },
        ),
        SizedBox(height: 10),
        BlocBuilder<SignupBloc,SignupState>(
            builder: (context,state) {
            if (state is SignupInitial){
              return Reusablewidgets(context).regularTextField(
              emailController,
              "Email",
              Icons.email_outlined,
              suffixIcon: Icons.close,
              onChanged: (newEmail) {
                print("new email == " + newEmail);
                BlocProvider.of<SignupBloc>(context).add(EmailVerificationEventSignUp(email: newEmail));
              },
              );
            }
            if (state is EmailIsMatchedStateSignUp){
              SaveEmailIsvalid = state.emailIsValid;
              return Reusablewidgets(context).regularTextField(
              emailController,
              "Email",
              Icons.email_outlined,
              suffixIcon: (state.emailIsValid) ? Icons.check : Icons.close,
              onChanged: (newEmail) {
                print("new email == " + newEmail);
                BlocProvider.of<SignupBloc>(context).add(EmailVerificationEventSignUp(email: newEmail));
              },
              );
            }
              return (SaveEmailIsvalid) ? Reusablewidgets(context).regularTextField(
              emailController,
              "Email",
              Icons.email_outlined,
              suffixIcon: Icons.check,
              onChanged: (newEmail) {
                print("new email == " + newEmail);
                BlocProvider.of<SignupBloc>(context).add(EmailVerificationEventSignUp(email: newEmail));
              },
              ) : Reusablewidgets(context).regularTextField(
              emailController,
              "Email",
              Icons.email_outlined,
              suffixIcon: Icons.close,
              onChanged: (newEmail) {
                print("new email == " + newEmail);
                BlocProvider.of<SignupBloc>(context).add(EmailVerificationEventSignUp(email: newEmail));
              },
              );
        }
        ),
        SizedBox(height: 10),
        BlocBuilder<SignupBloc,SignupState>(
            builder: (context,state) {
            if (state is SignupInitial){
              return Reusablewidgets(context).regularTextField(
                passwordController,
                "Password",
                Icons.lock_open_outlined,
                suffixIcon:Icons.visibility,
                isObscure: false,
                onChanged: (newPassword) {
                  print("new password == " + newPassword);
                },
                onPressedSuffixIcon: (){
                  BlocProvider.of<SignupBloc>(context).add(ReverseVisibilityEventSignUp());
                }
              );
            }
            if (state is VisibilityChangedStateSignUp){
              SaveVisibility = !state.visibilitySignUpVariable;
              return Reusablewidgets(context).regularTextField(
                passwordController,
                "Password",
                Icons.lock_open_outlined,
                suffixIcon: (state.visibilitySignUpVariable)? Icons.visibility:Icons.visibility_off,
                isObscure: !state.visibilitySignUpVariable,
                onPressedSuffixIcon: (){
                  BlocProvider.of<SignupBloc>(context).add(ReverseVisibilityEventSignUp());
                },
                onChanged: (newPassword) {
                  print("new password == " + newPassword);
                },
              ); 
            } 
            return (SaveVisibility) ? Reusablewidgets(context).regularTextField(
                passwordController,
                "Password",
                Icons.lock_open_outlined,
                suffixIcon:Icons.visibility_off,
                isObscure: true,
                onChanged: (newPassword) {
                  print("new password == " + newPassword);
                },
                onPressedSuffixIcon: (){
                  BlocProvider.of<SignupBloc>(context).add(ReverseVisibilityEventSignUp());
                }
              ): Reusablewidgets(context).regularTextField(
                passwordController,
                "Password",
                Icons.lock_open_outlined,
                suffixIcon:Icons.visibility,
                isObscure: false,
                onChanged: (newPassword) {
                  print("new password == " + newPassword);
                },
                onPressedSuffixIcon: (){
                  BlocProvider.of<SignupBloc>(context).add(ReverseVisibilityEventSignUp());
                }
              );
        }),
        SizedBox(height: 20),
        Container(alignment:Alignment.center,
        child:Reusablewidgets(context).mainButton("Sign up", 20, EdgeInsets.only(right:30,left:30,top:10,bottom: 10), ()async {
          print("sign up button is pressed");
          User newUser = User(
            email: emailController.text,
            username: userNameController.text,
            password: passwordController.text,
          );
          
          if (SaveEmailIsvalid){
            addUserData(newUser);
            Reusablewidgets(context).showCustomPopup(context, "Sign UP", "Congrats , your account is created successfully", "", "Ok");
            User? user = await getLastUserData();
            print("SIGN UP : user id here =  " + user!.id!.toString());
            setSharedprefuserId("user_id", user.id!); 
            // add task here 
            taskLaunching(15,15,user.id!);
            goTo(context, "userInfo");
          } else {
            Reusablewidgets(context).showCustomPopup(context, "Sign UP", "Verify your email please !", "", "Ok");
          }              
        })
        ),
        SizedBox(height: 20),
        Container(alignment:Alignment.center ,child: Text("Already joined us ?",style: TextStyle(color: AppStyles.hyperTextColor)),
        ),
        Reusablewidgets(context).hyperLinkNavigation("Login here", (){
          print("Login is pressed");
          goTo(context,"Login");
        }),
      ],
    ))
      ))
    );
  }
}