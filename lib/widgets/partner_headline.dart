// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:Arrival/data/partners.dart';
import 'package:Arrival/screens/details.dart';
import 'package:Arrival/styles.dart';

class ZoomClipAssetImage extends StatelessWidget {
  const ZoomClipAssetImage(
      {@required this.zoom,
      this.height,
      this.width,
      @required this.imageAsset});

  final double zoom;
  final double height;
  final double width;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: OverflowBox(
          maxHeight: height * zoom,
          maxWidth: width * zoom,
          child: Image.asset(
            imageAsset,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating({@required this.rating,});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        for (var i=1;i<6;i++) ...[
          SizedBox(width: 5),
          Icon(
            Styles.ratingIconData[i<rating ? 1 : (i-1<rating && rating%1>0.5 ? 2 : 0)],
            semanticLabel: rating.toString(),
            size: 12,
            color: Styles.ratingColors[i<rating ? 1 : (i-1<rating && rating%1>0.5 ? 2 : 0)],
          ),
        ],
      ],
    );
  }
}

class BusinessHeadline extends StatelessWidget {
  final Business biz;
  const BusinessHeadline(this.biz);

  @override
  Widget build(BuildContext context) {
    final themeData = CupertinoTheme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(CupertinoPageRoute(
        builder: (context) => DetailsScreen(biz.id),
        fullscreenDialog: true,
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZoomClipAssetImage(
            imageAsset: biz.images.logo,
            zoom: 2.4,
            height: 72,
            width: 72,
          ),
          SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      biz.name,
                      style: Styles.headlineName(themeData),
                    ),
                    // ..._buildSeasonDots(biz.seasons),
                  ],
                ),
                StarRating(rating: biz.rating,),
                Text(
                  biz.shortDescription,
                  style: Styles.headlineDescription(themeData),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VeggieHeadline extends StatelessWidget {
  final Veggie veggie;

  const VeggieHeadline(this.veggie);

  List<Widget> _buildSeasonDots(List<Season> seasons) {
    var widgets = <Widget>[];

    for (var season in seasons) {
      widgets.add(SizedBox(width: 4));
      widgets.add(
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: Styles.seasonColors[season],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = CupertinoTheme.of(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push<void>(CupertinoPageRoute(
        builder: (context) => DetailsScreen(veggie.id),
        fullscreenDialog: true,
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZoomClipAssetImage(
            imageAsset: veggie.imageAssetPath,
            zoom: 2.4,
            height: 72,
            width: 72,
          ),
          SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      veggie.name,
                      style: Styles.headlineName(themeData),
                    ),
                    ..._buildSeasonDots(veggie.seasons),
                  ],
                ),
                Text(
                  veggie.shortDescription,
                  style: Styles.headlineDescription(themeData),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
