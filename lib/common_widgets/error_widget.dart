import 'package:flutter/cupertino.dart';
import 'package:snowmanlabs_challenge/common_widgets/rounded_modal_widget.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:snowmanlabs_challenge/utils/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

showError({String error, BuildContext context}) {
  showRoundedModalBottomSheet(
      context: context,
      builder: (context) => Container(
            padding: EdgeInsets.symmetric(horizontal: w(20), vertical: w(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: w(80),
                  height: w(80),
                  child: SvgPicture.asset(
                    "assets/svg/snowmanlabs_error.svg",
                  ),
                ),
                SizedBox(height: w(20),),
                Text(
                  error,
                  style:
                      textStyle18().copyWith(color: SnowColors.blue, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ));
}
