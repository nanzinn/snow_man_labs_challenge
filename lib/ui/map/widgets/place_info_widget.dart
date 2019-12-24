import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:snowmanlabs_challenge/bloc/map_bloc.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:snowmanlabs_challenge/utils/conts.dart';
import 'package:snowmanlabs_challenge/utils/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaceInfoWidget extends StatelessWidget {
  final PlacesSearchResult result;

  PlaceInfoWidget(this.result);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        CarouselSlider(
          items: <Widget>[
            ...result?.photos
                ?.map((data) => Container(
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w(10)), topRight: Radius.circular(w(10))),
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(buildPhotoURL(data.photoReference))))))
                ?.toList()
          ],
          height: w(180),
          initialPage: 0,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: result.photos != null && result.photos.length > 1,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          pauseAutoPlayOnTouch: Duration(seconds: 10),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: w(20), vertical: w(40)),
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          result.name,
                          style: textStyle14().copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: w(10),
                        ),
                        Text(
                          result.formattedAddress,
                          style: textStyle14().copyWith(color: SnowColors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: w(20)),
                  Container(
                    padding: EdgeInsets.all(w(10)),
                    width: w(40),
                    height: w(40),
                    decoration: BoxDecoration(
                        border: Border.all(width: w(2), color: SnowColors.red),
                        borderRadius: BorderRadius.circular(w(10))),
                    child: SvgPicture.asset(
                      "assets/svg/ic_heart.svg",
                      fit: BoxFit.none,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: w(20),
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  starCount: 5,
                  rating: result.rating,
                  size: w(25),
                  color: SnowColors.blue,
                  spacing: 0.0),
              SizedBox(
                height: w(40),
              ),
              Text(
                "Category",
                style: textStyle14().copyWith(color: SnowColors.grey),
              ),
              Text(
                result.types.toList().toString(),
                style: textStyle14().copyWith(color: SnowColors.grey),
              ),
              SizedBox(
                height: w(40),
              ),
              Text(
                "About",
                style: textStyle14().copyWith(color: SnowColors.grey),
              ),
              Text(
                result.reference,
                style: textStyle14().copyWith(color: SnowColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${GOOGLE_API}";
  }
}
