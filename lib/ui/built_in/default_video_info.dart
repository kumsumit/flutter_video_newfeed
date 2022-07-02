import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_video_newfeed/flutter_video_newfeed.dart';

import 'favorite_button.dart';

class DefaultVideoInfoWidget extends StatelessWidget {
  final VideoInfo videoinfo;
  final Future<bool> Function(bool) onLikePressed;
  final void Function() onMorePressed;
  const DefaultVideoInfoWidget({
    Key? key,
    required this.videoinfo,
    required this.onLikePressed,
    required this.onMorePressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              /// Username, time, brand information
              ///
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _userNameAndTimeUploadedWidget(),
                  SizedBox(height: 8.0),

                  /// location widget
                  ///
                  if (videoinfo.location != null) _locationWidget(),
                  if (videoinfo.location != null) SizedBox(height: 8.0),

                  _timeuploadWidget(),
                  SizedBox(height: 8.0),

                  /// rainbow brand
                  ///
                  _rainBowBrandWidget(),
                  SizedBox(height: 8.0),

                  /// song name
                  ///
                  if (videoinfo.songName != null) _songNameWidget(),
                  if (videoinfo.songName != null) SizedBox(height: 8.0),
                ],
              ),

              /// Like, more.
              ///
              _likeMoreWidget()
            ],
          ),
        ),
      ],
    );
  }

  Widget _locationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          child: Text(
            videoinfo.location ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Like heart icon: tap to increase like number
  /// More option: tap to share or edit
  ///
  Widget _likeMoreWidget() {
    // String like = "0";
    // if (videoinfo.numberOfLikes != null) {
    //   if (videoinfo.numberOfLikes! < 1000) {
    //     like = videoinfo.numberOfLikes.toString();
    //   } else if (videoinfo.numberOfLikes! > 1000000) {
    //     like = (videoinfo.numberOfLikes! / 1000).toStringAsFixed(3) + 'k';
    //   } else {
    //     (videoinfo.numberOfLikes! / 1000000.0).toStringAsFixed(3) + 'm';
    //   }
    // }
    // String view = "0";
    // if (videoinfo.numberOfViews != null) {
    //   if (videoinfo.numberOfViews! < 1000) {
    //     view = videoinfo.numberOfViews.toString();
    //   } else if (videoinfo.numberOfViews! > 1000 &&
    //       videoinfo.numberOfViews! < 1000000) {
    //     view = (videoinfo.numberOfViews! / 1000).toStringAsFixed(3) + 'k';
    //   } else {
    //     (videoinfo.numberOfViews! / 1000000.0).toStringAsFixed(3) + 'm';
    //   }
    // }
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.visibility,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 8.0),
              Text(
                (videoinfo.numberOfViews ?? 0).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 0.16,
                    fontFamily: "Inter",
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.white,
                size: 14,
              ),
              SizedBox(width: 8.0),
              Text(
                (videoinfo.numberOfLikes ?? 0).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 0.16,
                    fontFamily: "Inter",
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 5),
          FavoriteButton(
            initFavorite: videoinfo.liked ?? false,
            onFavoriteClicked: onLikePressed,
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: onMorePressed,
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Render song name, auto scroll
  ///
  Widget _songNameWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.music_note,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          height: 20,
          child: Center(
            child: Marquee(
              text: videoinfo.songName ?? "",
              style: TextStyle(color: Colors.white),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              startPadding: 10.0,
              velocity: 50.0,
              showFadingOnlyWhenScrolling: true,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
            ),
          ),
        )
      ],
    );
  }

  /// Rainbow branch information
  Widget _rainBowBrandWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.compass,
          color: Colors.white,
          size: 16,
        ),
//        Image(
//          image: ,
//          width: 16,
//          height: 16,
//          color:  Colors.white,
//        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          child: Text(
            videoinfo.category ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _timeuploadWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.timer_outlined,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          child: Text(
            videoinfo.uploadTime != null
                ? timeago.format(videoinfo.uploadTime!)
                : "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Show user name and the time video uploaded
  ///
  Widget _userNameAndTimeUploadedWidget() {
    print(videoinfo.uploadTime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          videoinfo.userName ?? "",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: [
            Container(
              width: 4,
              height: 4,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(3)),
            ),
            InkWell(
              onTap: () {
                print("following");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "follow",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
