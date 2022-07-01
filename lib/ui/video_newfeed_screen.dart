import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_video_newfeed/api/api.dart';
import 'package:flutter_video_newfeed/config/screen_config.dart';
import 'package:flutter_video_newfeed/config/video_item_config.dart';
import 'package:flutter_video_newfeed/model/video.dart';
import 'package:flutter_video_newfeed/ui/video_item.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

import '../model/video.dart';

class VideoNewFeedScreen<V extends VideoInfo> extends StatefulWidget {
  /// Is case you want to keep the screen
  ///
  final bool keepPage;

  final Future<bool> Function(bool) onLikePressed;
  final void Function() onMorePressed;

  ///
  /// Screen config
  final ScreenConfig screenConfig;

  /// http headers for token
  final Map<String, String> httpHeaders;

  ///
  /// Video Item config
  final VideoItemConfig config;

  final VideoNewFeedApi<V> api;

  /// Video ended callback
  ///
  final void Function()? videoEnded;

  /// Video Info Customizable
  ///
  final Widget Function(BuildContext context, V v)? customVideoInfoWidget;
  static const List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  const VideoNewFeedScreen({
    this.keepPage = false,
    required this.httpHeaders,
    required this.onLikePressed,
    required this.onMorePressed,
    this.screenConfig = const ScreenConfig(
      backgroundColor: Colors.black,
      loadingWidget: LoadingIndicator(
          indicatorType: Indicator.lineScale,

          /// Required, The loading type of the widget
          colors: _kDefaultRainbowColors,

          /// Optional, The color collections
          strokeWidth: 7,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          backgroundColor: Colors.black,

          /// Optional, Background of the widget
          pathBackgroundColor: Colors.black

          /// Optional, the stroke backgroundColor
          ),
    ),

    /// video config
    this.config = const VideoItemConfig(
        loop: true,
        itemLoadingWidget: CircularProgressIndicator(),
        autoPlayNextVideo: true),
    this.customVideoInfoWidget,
    this.videoEnded,
    required this.api,
  });

  @override
  State<StatefulWidget> createState() => _VideoNewFeedScreenState<V>();
}

class _VideoNewFeedScreenState<V extends VideoInfo>
    extends State<VideoNewFeedScreen<V>> {
  /// PageController
  ///
  late PageController _pageController;

  /// Current page is on screen
  ///
  int _currentPage = 0;

  /// Page is on turning or off, use to check how much percent the next video will render and play
  ///
  bool _isOnPageTurning = false;

  final _listVideoStream = StreamController<List<V>>();

  /// Temp to update list video data
  ///
  List<V> temps = [];

  void setList(List<V> items) {
    if (!_listVideoStream.isClosed) {
      _listVideoStream.sink.add(items);
    }
  }

  void _notifyDataChanged() => setList(temps);

  /// Check to play next video when user scroll
  /// If the next video appear about 30% (0.7) the next video will play
  ///
  void _scrollListener() {
    if (_isOnPageTurning &&
        _pageController.page == _pageController.page!.roundToDouble()) {
      setState(() {
        _currentPage = _pageController.page!.toInt();
        _isOnPageTurning = false;
      });
    } else if (!_isOnPageTurning &&
        _currentPage.toDouble() != _pageController.page) {
      if ((_currentPage.toDouble() - _pageController.page!).abs() > 0.7) {
        setState(() {
          _isOnPageTurning = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: widget.keepPage);
    _pageController.addListener(_scrollListener);
    _getListVideo();
  }

  void _getListVideo() {
    widget.api.getListVideo().then((value) {
      temps.addAll(value);
      _notifyDataChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.screenConfig.backgroundColor,
      body: _renderVideoPageView(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listVideoStream.close();
    super.dispose();
  }

  /// Page View
  ///
  Widget _renderVideoPageView() {
    return StreamBuilder<List<VideoInfo>>(
        stream: _listVideoStream.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(
                child: widget.screenConfig.emptyWidget ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/no_result.json"),
                        Text("No result.")
                      ],
                    ));
          return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemCount: snapshot.data!.length,
            onPageChanged: (page) {},
            itemBuilder: (context, index) {
              return VideoItemWidget(
                onLikePressed: widget.onLikePressed,
                onMorePressed: widget.onMorePressed,
                videoInfo: snapshot.data![index],
                httpHeaders: widget.httpHeaders,
                pageIndex: index,
                currentPageIndex: _currentPage,
                isPaused: _isOnPageTurning,
                config: widget.config,
                videoEnded: widget.videoEnded,
                customVideoInfoWidget: widget.customVideoInfoWidget != null
                    ? widget.customVideoInfoWidget!(context, temps[index])
                    : null,
              );
            },
          );
        });
  }
}
