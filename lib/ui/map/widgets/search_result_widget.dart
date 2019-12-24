import 'package:flutter/material.dart';
import 'package:snowmanlabs_challenge/bloc/map_bloc.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:snowmanlabs_challenge/utils/conts.dart';
import 'package:snowmanlabs_challenge/utils/theme.dart';
import 'package:meet_network_image/meet_network_image.dart';

class SearchResultWidget extends StatelessWidget {
  final PlacesSearchResult searchResult;
  final Function onTap;

  SearchResultWidget({this.searchResult, this.onTap});

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${GOOGLE_API}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w(10), vertical: w(15)),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: searchResult.photos?.first?.photoReference != null
                  ? MeetNetworkImage(
                      width: w(35),
                      height: w(35),
                      fit: BoxFit.fill,
                      imageUrl: buildPhotoURL(searchResult.photos?.first?.photoReference),
                      loadingBuilder: (context) => Center(
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(w(8)),
                            child: CircularProgressIndicator()),
                      ),
                      errorBuilder: (context, e) => Center(
                        child: Container(
                            color: SnowColors.lightGrey,
                            height: w(35),
                            width: w(35),
                            child: Icon(
                              Icons.panorama,
                              size: w(15),
                              color: SnowColors.grey,
                            )),
                      ),
                    )
                  : Center(
                      child: Container(
                          color: SnowColors.lightGrey,
                          height: w(35),
                          width: w(35),
                          child: Icon(
                            Icons.panorama,
                            size: w(15),
                            color: SnowColors.grey,
                          )),
                    ),
            ),
            SizedBox(
              width: w(10),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    searchResult.name,
                    style: textStyle12()
                        .copyWith(color: SnowColors.grey1, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: w(5),
                  ),
                  Text(
                    searchResult.formattedAddress,
                    style: textStyle11().copyWith(color: SnowColors.grey),
                    maxLines: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
