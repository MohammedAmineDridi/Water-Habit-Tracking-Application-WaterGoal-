import 'package:flutter/material.dart';
import '../themes/appStyles.dart';


class Reusablewidgets {

  late BuildContext context;

  Reusablewidgets(BuildContext context){
    this.context = context;
  }

  // ----------------------------------------------- 1 - custom popUp Widget ---------------------------------------------
  
  void showCustomPopup(BuildContext context, String popUpTitle, String popUpMessage  ,String btnYesString,String btnNoString, {VoidCallback? onYesPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppStyles.popupBackgroundColor,
          title: Center(child:Text(popUpTitle,style:AppStyles.subTitleStyle)),
          content: Text(popUpMessage,style:AppStyles.textKeyStyle),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onYesPressed!();
              },
              child: Text(btnYesString,style:AppStyles.textKeyStyle),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(btnNoString,style:AppStyles.textKeyStyle),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------- 2 - Main Button Widget ---------------------------------------------

  Widget mainButton(String buttonText, double radius,EdgeInsetsGeometry padding, VoidCallback onPressed){
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        color: Colors.blue,
        child: Padding(padding: padding,child:Text(buttonText,style:AppStyles.textButtonStyle)),
        onPressed: (){
          onPressed();
        });
  }

  // ----------------------------------------------- 3 - Title Widget ---------------------------------------------

  Widget customTitle(String titleString, double marginRight, double marginLeft){
    return Container(
        margin: EdgeInsets.only(right:marginRight,left:marginLeft),
        alignment:Alignment.center ,child:Text(titleString,style: AppStyles.titleStyle),
        decoration: BoxDecoration(color: AppStyles.titleBorderColor,borderRadius: BorderRadius.circular(50))
        );
  } 

 // ----------------------------------------------- 4 - hyperLink Widget for navigation ---------------------------------------------

  Widget hyperLinkNavigation(String textHyperText,VoidCallback onPressed){
    return Container(alignment:Alignment.center ,child:TextButton(
              onPressed: () {
                onPressed();
              },
              child: Text(textHyperText,style: AppStyles.textHyperlinkStyle),
            ),
          );
  }

  // ----------------------------------------------- 5 -  arrow Icon ---------------------------------------------

  Widget IconPressed(IconData? icon,VoidCallback onPressed){
    return Container(alignment: Alignment.centerLeft,child:IconButton(icon:Icon(icon),color:AppStyles.iconColor,onPressed: () {
    onPressed();
  }));
  }
 
  // ----------------------------------------------- 6 - custom Line TextField -----------------------------------------------

  Widget lineTextField(TextEditingController controller , int maxLength , Function(String) onChanged ){
    return TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        controller: controller,
        cursorColor: AppStyles.textFieldCursorColor,
        decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color:AppStyles.lineTextFieldBorderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:AppStyles.lineTextFieldBorderColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:AppStyles.lineTextFieldBorderColor),
        ),
        counterText: "",
        ),
        style: TextStyle(fontSize: 16,color: AppStyles.linetextFieldColor),
        onChanged: (newvalue) {
        onChanged(newvalue);
        },
        );
  }

  // ----------------------------------------------- 6 - custom Regular TextField -----------------------------------------------

  Widget regularTextField(TextEditingController controller , String hintText , IconData prefixIcon , { IconData? suffixIcon,VoidCallback? onPressedSuffixIcon, Function(String)? onChanged ,String? type , bool? isObscure = false, VoidCallback? onPressedIcon}){
    return TextField(
        obscureText: isObscure!,
        readOnly: type == "date" ? true : false,
        controller: controller,
        cursorColor: AppStyles.textFieldCursorColor,
        style: AppStyles.textfieldStyle,
        decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30) , borderSide: BorderSide(color: AppStyles.textFieldCursorColor, width: 2.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30) , borderSide: BorderSide(color: AppStyles.textFieldCursorColor, width: 2.0)),
        hintText: hintText , hintStyle: AppStyles.textfieldHintTextStyle , 
        prefixIcon: type == "date" ? IconButton(icon:Icon(prefixIcon,color:AppStyles.textFieldIconColor),onPressed:(){onPressedIcon!();}) : Icon(prefixIcon,color:AppStyles.textFieldIconColor),
        suffixIcon: IconButton(icon:Icon(suffixIcon,color:AppStyles.textFieldIconColor),onPressed: (){
          onPressedSuffixIcon!();
        })
        ),
        onChanged: (newValue) {
          onChanged!(newValue);
        },
      );
  }
}