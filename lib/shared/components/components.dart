import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

Widget defaultButton( {
  required Color backColor,
  required Color color,
  required double width,
  required String text,
  final Function()? onPressed,
  double radius = 2.0,
}) => Container(
  width: width,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: color
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: backColor,
  ),
);





Widget defaultTextForm({
  required TextEditingController controller,
  required String labeltext,
  final String? Function(String?)? validate,
  final Function(String)? onfieldSubmitted,
  final Function(String)? onfieldChange,
  final Function()? onTap,
  required TextInputType textInputType,
  IconData? prefix,
  IconData? suffix,
  bool obscuretext = false,
  Function()? setSuffix,
  bool isEnabled = true,


}) =>TextFormField(
  onChanged: onfieldChange,
  controller: controller,
  keyboardType: textInputType ,
  onFieldSubmitted: onfieldSubmitted,
  obscureText: obscuretext,
  onTap: onTap,
  enabled: isEnabled,
  decoration: InputDecoration(
    labelText: '$labeltext',
    border: OutlineInputBorder(),
    prefixIcon: prefix != null ?  Icon(prefix): null,
    suffixIcon: suffix != null ? IconButton(icon: Icon(suffix), onPressed: setSuffix,): null,
  ),
  validator: validate,

);


Widget myDivider() => Padding(
  padding: const EdgeInsets.only(
    left: 20.0,right: 20.0
  ),
  child:   Container(

    width: double.infinity,

    height: 1.0,

    color: Colors.grey[300],

  ),
);


void NavigateTo(context,Widget) =>Navigator.push( context, MaterialPageRoute(builder: (context)=>Widget,));


void PushAndReplace (context, Widget) =>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>Widget),(Route<dynamic> route)=>false);






