import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  var token = await FirebaseMessaging.instance.getToken();
  //print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
//hello
  // hello 2
  Bloc.observer = MyBlocObserver();

  await CachHelper.init();
  Widget widget;
  bool? isDark = CachHelper.getData(key: "isDark");
  uId = CachHelper.getData(key: "uId");
  // token = CachHelper.getData(key: "token");
  // bool? onBoarding = CachHelper.getData(key: "onBoarding");
  // print(token);
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreeen();
  // }
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SocialCubit()
                ..getUserData()
                ..getPosts()),
        ],
        child: MaterialApp(
          darkTheme: darkTheme,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          home: startWidget,
          debugShowCheckedModeBanner: false,
        ));
  }
}
