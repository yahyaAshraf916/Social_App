import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 3,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40,
      color: backgroundColor,
      child: ElevatedButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget defulteditTextx({
  required TextEditingController Controller,
  required TextInputType keyboardType,
  GestureTapCallback? onTap,
  required FormFieldValidator<String> validator,
  required String Label,
  required dynamic prefix,
  IconData? suffix,
  bool? isPassword = false,
  Function? suffixPressed()?,
  Function? onchanged(value)?,
  Function? onSubmitted(value)?,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword!,
      controller: Controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      onChanged: onchanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: Label,
        border: const OutlineInputBorder(),
        prefixIcon: prefix,
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
      ),
    );
Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(title!),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const ImageIcon(AssetImage("assets/images/Arrow - Left 2")),
      ),
      actions: actions,
    );


Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false,
    );
void showToast({
  required text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  SUCCSESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCSESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
  }
  return color;
}


