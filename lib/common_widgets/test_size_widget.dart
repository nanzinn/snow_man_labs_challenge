import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestSizeWidget extends StatefulWidget {
  final Widget child;

  TestSizeWidget({this.child});

  @override
  _TestSizeWidgetState createState() => _TestSizeWidgetState();
}

class _TestSizeWidgetState extends State<TestSizeWidget> {
  final List<Size> androidScreens = [
    Size(2160, 3840),
    Size(1440, 3440),
    Size(1800, 3200),
    Size(1440, 2560),
    Size(1440, 2160),
    Size(1080, 2280),
    Size(1440, 2160),
    Size(1080, 2048),
    Size(1080, 1920),
    Size(900, 1600),
    Size(768, 1366),
    Size(768, 1024),
    Size(540, 960),
    Size(480, 640),
    Size(360, 640),
    Size(240, 320),
  ];

  final List<Size> iOSScreens = [
    Size(1242, 2688),
    Size(1125, 2436),
    Size(1242, 2208),
    Size(828, 1792),
    Size(750, 1334),
    Size(640, 1136),
    Size(640, 960),
    Size(320, 480),
  ];

  List<Size> selectedPlatformScreens;

  double currentWidth;
  double currentHeight;
  double progressScreenSize = 0;
  double customWidthProgressScreenSize = 0;
  double customHeightProgressScreenSize = 0;
  bool isAndroid = true;
  GlobalKey<FlipCardState> _customKey;
  bool _isCustomCardFront = true;
  bool _simulateNotch = false;
  MediaQueryData _mediaQueryData;
  @override
  void initState() {
    selectedPlatformScreens = androidScreens;
    _customKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentWidth = ScreenUtil.screenWidth;
      currentHeight = ScreenUtil.screenHeight;
      setListScreens();
      progressScreenSize = 0;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _mediaQueryData = changeMediaQueryDataSize(
        new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      drawerScrimColor: Colors.black26,
      endDrawer: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlipCard(
                flipOnTouch: false,
                key: _customKey,
                front: Column(
                  children: <Widget>[
                    FlipCard(
                      onFlip: () {
                        isAndroid = !isAndroid;
                        setListScreens();
                        progressScreenSize = 0;
                        setState(() {});
                      },
                      direction: FlipDirection.VERTICAL,
                      front: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                            child: Text(
                          "Droid",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      back: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey, borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          "iOS",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _blurredContainerWidget(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "w${selectedPlatformScreens[progressScreenSize.toInt()].width.toInt()}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "h${selectedPlatformScreens[progressScreenSize.toInt()].height.toInt()}"),
                          SizedBox(
                            height: 10,
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Slider(
                                value: progressScreenSize,
                                min: 0,
                                max: (selectedPlatformScreens.length).toDouble() - 1,
                                divisions: selectedPlatformScreens.length -1,
                                onChanged: (value) {
                                  progressScreenSize = value;
                                  changeSizeMediaQuery();
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                back: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    _blurredContainerWidget(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "w${customWidthProgressScreenSize.round()}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "h${customHeightProgressScreenSize.round()}"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Slider(
                                      value: customWidthProgressScreenSize,
                                      min: 0,
                                      max: currentWidth ?? 1,
                                      onChanged: (value) {
                                        customWidthProgressScreenSize = value;
                                        changeSizeMediaQuery();
                                        setState(() {});
                                      }),
                                ),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Slider(
                                      value: customHeightProgressScreenSize,
                                      min: 0,
                                      max: currentHeight ?? 1,
                                      onChanged: (value) {
                                        customHeightProgressScreenSize = value;
                                        changeSizeMediaQuery();
                                        setState(() {});
                                      }),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _isCustomCardFront = !_isCustomCardFront;
                  if (_isCustomCardFront) {
                    progressScreenSize = 0;
                    setState(() {});
                  }
                  customWidthProgressScreenSize = currentWidth;
                  customHeightProgressScreenSize = currentHeight;
                  _customKey.currentState.toggleCard();
                  setState(() {});
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration:
                      BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "Custom",
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _simulateNotch = !_simulateNotch;
                  setState(() {});
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration:
                      BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "Notch",
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      body: MediaQuery(
        data: _mediaQueryData,
        child: Container(
          child: ScreenUtilUpdater(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Stack(children: <Widget>[
                  widget.child,
                  if (_simulateNotch)
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(w(10)),
                                bottomRight: Radius.circular(w(10)))),
                        height: w(MediaQuery.of(context).padding.top),
                        width: w(100),
                      ),
                    ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  MediaQueryData changeMediaQueryDataSize(Size size) {
    return new MediaQueryData(
      size: size,
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      padding: true

          ///TODO (_disableBottomPadding)
          ? new EdgeInsets.fromLTRB(MediaQuery.of(context).padding.left,
              MediaQuery.of(context).padding.top, MediaQuery.of(context).padding.right, 0.0)
          : MediaQuery.of(context).padding,
      viewInsets: MediaQuery.of(context).viewInsets,
      alwaysUse24HourFormat: MediaQuery.of(context).alwaysUse24HourFormat,
      accessibleNavigation: MediaQuery.of(context).accessibleNavigation,
      invertColors: MediaQuery.of(context).invertColors,
      disableAnimations: MediaQuery.of(context).disableAnimations,
      boldText: MediaQuery.of(context).boldText,
    );
  }

  void changeSizeMediaQuery() {
    _mediaQueryData = changeMediaQueryDataSize(new Size(getWidth(), getHeight()));
  }

  void setListScreens(){
    List<Size> backList = isAndroid ? androidScreens : iOSScreens;

    int yourIndex = getYourScreenIndex(backList);

    if(yourIndex == -1){
      yourIndex = backList.indexOf(backList
          .firstWhere((screen) => screen.height <= currentHeight && screen.width <= currentWidth));

      backList.insert(yourIndex, Size(currentWidth,currentHeight));
    }

    selectedPlatformScreens = backList.getRange(yourIndex, backList.length ).toList();
    setState(() {
    });
    changeSizeMediaQuery();
  }

  int getYourScreenIndex(List<Size> listToSearch) {
    return listToSearch.indexOf(listToSearch
        .firstWhere((screen) => screen.height == currentHeight && screen.width == currentWidth, orElse: ()=> Size(0,0)));
  }

  Widget _blurredContainerWidget({Widget child}) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child),
      ),
    );
  }

  double getWidth() {
    if (_isCustomCardFront) {
      return (selectedPlatformScreens[progressScreenSize.toInt()].width *
              MediaQuery.of(context).size.width) /
          currentWidth;
    }

    return (customWidthProgressScreenSize * MediaQuery.of(context).size.width) / currentWidth;
  }

  double getHeight() {
    if (_isCustomCardFront) {
      return (selectedPlatformScreens[progressScreenSize.toInt()].height *
              MediaQuery.of(context).size.height) /
          currentHeight;
    }

    return (customHeightProgressScreenSize * MediaQuery.of(context).size.height) / currentHeight;
  }
}
