import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watergoal/core/routing/routers.dart';
import 'package:watergoal/logic_presentation_layer/features/login/bloc/login_bloc.dart';
import 'package:watergoal/logic_presentation_layer/themes/appStyles.dart';
import '../../../widgets/reusableWidgets.dart';
import '../../../../data_layer/models/user.dart';
import '../data/loginData.dart';
import '../../../../core/helpers/helpers.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatelessWidget {

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child:Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child:Container(
      //decoration: BoxDecoration(color:Colors.purple),
      margin: EdgeInsets.only(top:60,bottom: 10,right: 10,left: 10),
      padding: EdgeInsets.only(top: 10),
      child:Column(
      children: [
        Reusablewidgets(context).IconPressed( Icons.arrow_back_ios_rounded , (){
          print("arrow icon pressed");
          goTo(context, "getStarted");
        }),
        Reusablewidgets(context).customTitle("Login",100,100),
        SizedBox(height: 10),
        Container(alignment:Alignment.center ,child:Image.asset(AppStyles.loginImage),
        //decoration: BoxDecoration(color: Colors.red)
        ),
        SizedBox(height: 20),
        // text inputs here (username , password)
        // 1 - username 
        Reusablewidgets(context).regularTextField(
        userNameController,
        "userName",
        Icons.person_outline_outlined,
        onChanged: (newUserName) {
          print("new user name == " + newUserName);
        },
        ),
        SizedBox(height: 20),
        // 2 - password 
        BlocBuilder<LoginBloc,LoginState>(
            builder: (context,state) {
            if (state is LoginInitial){
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
                  // throw event here 
                  BlocProvider.of<LoginBloc>(context).add(ReverseVisibilityEventLogin());
                }
              );
            }
            if (state is VisibilityChangedStateLogin){
              return Reusablewidgets(context).regularTextField(
                passwordController,
                "Password",
                Icons.lock_open_outlined,
                suffixIcon: (state.visibilityLoginVariable)? Icons.visibility:Icons.visibility_off,
                isObscure: !state.visibilityLoginVariable, // bcz : obscuer = false (shown psw)
                onPressedSuffixIcon: (){
                  // throw event here 
                  BlocProvider.of<LoginBloc>(context).add(ReverseVisibilityEventLogin());
                },
                onChanged: (newPassword) {
                  print("new password == " + newPassword);
                },
              ); 
            } 
            return SizedBox();
        }),
        SizedBox(height: 20),

        Container(alignment:Alignment.center,
        //decoration: BoxDecoration(color: Colors.black),
        child: Reusablewidgets(context).mainButton("Login", 20,EdgeInsets.only(right:60,left:60,top:10,bottom: 10), () async {
          print("Login btn is pressed");
          // verif login
          User? user = await getUserByUsernamePasswordData(
          userNameController.text,
          passwordController.text,
          );
          if (user != null) {
            print("login correct");
            setSharedprefuserId("user_id",user.id!); // always (in every login) update the value of user_id = ...
            final userId = await getSharedprefuserId("user_id");
            print("user_id = "+userId.toString());
            // launching task
            bool isTaskLaunched = await getSharedprefTaskLauncher('isTaskLaunched') ?? false;
            if (!isTaskLaunched) {
              //taskLaunching(15, 1); // (set launching time as you want)
              print("Task launched for the first time");
            } else {
              print("Task has already been launched");
            }
            goTo(context, "stayHydrated");
          } else {
            // Show a popup or alert for login incorrect
            Reusablewidgets(context).showCustomPopup(context, "Login Error", "Error , verify your credentials", "", "Ok");
            print("login incorrect");
          }
        })
        )
      ],
    ))
    )
    ));
  }
}