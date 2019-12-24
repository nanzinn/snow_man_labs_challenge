import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilWidget {

  static void init(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 320.0 , height: 568.0 , allowFontScaling: true)
      ..init(context);
  }
}

double w(double size) {
  return ScreenUtil.instance.setWidth(size);
}

double h(double size) {
  return ScreenUtil.instance.setHeight(size);
}

class ScreenUtilUpdater extends StatelessWidget {
  final Widget child;


  ScreenUtilUpdater({this.child});

  @override
  Widget build(BuildContext context) {
   ScreenUtilWidget.init(context);
    return Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: child);
  }
}

