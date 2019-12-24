import 'package:flutter/material.dart';
import 'package:snowmanlabs_challenge/ui/login/login_page.dart';
import 'common_widgets/screen_size_widget.dart';
import 'common_widgets/test_size_widget.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _timeToSplash = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SnowManLabs Challenge',
        initialRoute: '/login',
        builder: (BuildContext context, Widget widget) => _timeToSplash
            ? Stack(
                children: <Widget>[
                  SplashScreen.callback(
                    name: 'assets/flare/snow_moutain.flr',
                    fit: BoxFit.fill,
                    onSuccess: (_) {
                      setState(() {
                        _timeToSplash = false;
                      });
                    },
                    until: () => Future.delayed(Duration(seconds: 4)),
                    startAnimation: 'success',
                    onError: (error, stacktrace) {
                      print(error);
                    },
                  ),
                ],
              )
            : ScreenUtilUpdater(
                child: TestSizeWidget(
                  child: widget,
                ),
              ),
        routes: <String, WidgetBuilder>{
          '/login': (context) => LoginPage(),
        });
  }
}

//return MaterialApp(
//title: 'SnowManLabs Challenge',
//initialRoute: '/',
//builder: (BuildContext context, Widget widget) {
//return  SplashScreen.callback(
//name: 'assets/flare/snow-moutain.flr',
//fit: BoxFit.fitHeight,
//onSuccess: (_) {
//Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_,__,___) => LoginPage()));
//},
//
//until: () => Future.delayed(Duration(seconds: 4)),
//startAnimation: 'success',
//);
//return ScreenUtilUpdater(
//child: TestSizeWidget(
//child: widget,
//),
//);
//
//},
//routes: <String, WidgetBuilder>{
//'/': (context) => LoginPage(),
//},
//);
