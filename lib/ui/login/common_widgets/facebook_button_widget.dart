import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:snowmanlabs_challenge/utils/theme.dart';

class FacebookButtonWidget extends StatefulWidget {
  final String text;
  final Function onTap;
  final bool invert;

  FacebookButtonWidget({this.text, this.onTap, this.invert = false});

  @override
  _FacebookButtonWidgetState createState() => _FacebookButtonWidgetState();
}

class _FacebookButtonWidgetState extends State<FacebookButtonWidget> {
  bool invert;

  @override
  void initState() {
    invert = widget.invert;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (tap){
        setState(() {
          invert = !invert;
        });
      },
      onTapUp: (tap){
        invert = !invert;
        setState(() {
        });
      },
      onTapCancel: (){
        setState(() {
          invert = widget.invert;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: w(20)),
        padding: EdgeInsets.symmetric(vertical: w(15), horizontal: w(20)),
        decoration: BoxDecoration(
            color: invert ? Colors.white : Colors.blue[900],
            borderRadius: BorderRadius.circular(w(10)),
            border:  Border.all(width: 1, color: SnowColors.blue)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/svg/facebook.svg",
              color: invert ? Colors.blue[900] : Colors.white,
              width: w(20),
              height: w(20),
            ),
            SizedBox(
              width: w(10),
            ),
            Text(
              widget.text,
              style: textStyle14().copyWith(
                  color: invert ? Colors.blue[900] : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
