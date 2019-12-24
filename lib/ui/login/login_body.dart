import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snowmanlabs_challenge/bloc/login_bloc.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:snowmanlabs_challenge/ui/login/common_widgets/facebook_button_widget.dart';
import 'package:snowmanlabs_challenge/utils/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flip_card/flip_card.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with SingleTickerProviderStateMixin {
  AnimationController _challengeTextController;
  Animation<Offset> _challengeTextOffset;
  GlobalKey<FlipCardState> _loadingKey;

  @override
  void initState() {
    _loadingKey = GlobalKey();
    _challengeTextController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _challengeTextOffset = Tween<Offset>(begin: Offset(0.0, -w(0.3)), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _challengeTextController,
        curve: Interval(
          0,
          1,
          curve: Curves.bounceInOut,
        ),
      ),
    );

    Future.delayed(Duration(milliseconds: 2500), () {
      _challengeTextController.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilWidget.init(context);
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "assets/svg/background_cells.svg",
          ),
        ),
        FlipCard(front: _centerWidget(), back: _loadingWidget(), flipOnTouch: false,key: _loadingKey,)
      ],
    );
  }

  Widget _centerWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w(30), vertical: w(30)),
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: new Offset(5.0, 10.0),
          )
        ], borderRadius: BorderRadius.circular(w(10)), color: Colors.white),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(child: SizedBox(height: w(20))),
              SizedBox(height: w(20)),
              Stack(
                children: <Widget>[
                  SlideTransition(
                    position: _challengeTextOffset,
                    child: Padding(
                      padding: EdgeInsets.only(top: w(140)),
                      child: Center(
                        child: Text(
                          "CHALLENGE",
                          style: textStyle20().copyWith(color: SnowColors.blue, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                        color: Colors.white,
                        width: w(150),
                        height: w(120),
                        child: FlareActor(
                          "assets/flare/snowmanlabs_logo.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                          animation: "Untitled",
                          snapToEnd: false,
                        )),
                  ),
                ],
              ),

              Flexible(child: SizedBox(height: w(40))),
              SizedBox(height: w(20)),
              FacebookButtonWidget(
                  onTap: () {
                    _loadingKey.currentState.toggleCard();
                    Future.delayed(Duration(seconds: 5), () async {
                       await getLoginBLoC(context).signIn(context);
                      _loadingKey.currentState.toggleCard();
                    });
                  },
                  invert: true,
                  text: "Sign in with Facebook"),
              SizedBox(height: w(20)),
              FacebookButtonWidget(
                  onTap: () {
                    _loadingKey.currentState.toggleCard();
                    Future.delayed(Duration(seconds: 5), () async {
                      await getLoginBLoC(context).signUp(context);
                      _loadingKey.currentState.toggleCard();
                    });
                  },
                  text: "Sign up with Facebook"),
              SizedBox(height: w(5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w(30), vertical: w(30)),
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: new Offset(5.0, 10.0),
          )
        ], borderRadius: BorderRadius.circular(w(10)), color: Colors.white),
        child:IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: w(10)),
                width: w(100),
                height: w(100),
                child: FlareActor(
                  "assets/flare/snowmanlabs_icon.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  animation: "loading",
                  snapToEnd: false,
                ),
              ),
              SizedBox(height: w(10),),
              Text("Carregando...",style: textStyle15().copyWith(color: SnowColors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
        ) ,
      ),
    );
  }
}
