import 'package:flutter/material.dart';
import 'package:flutter_video_newfeed/api/api.dart';
import 'package:flutter_video_newfeed/model/video.dart';
import 'package:flutter_video_newfeed/ui/video_newfeed_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Video New Feed'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements VideoNewFeedApi<VideoInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoNewFeedScreen<VideoInfo>(
        api: this,
      ),
    );
  }

  @override
  Future<List<VideoInfo>> getListVideo() {
    return Future.value([
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
    ]);
  }

  @override
  Future<List<VideoInfo>> loadMore(List<VideoInfo> currentList) {
    return Future.value([
      VideoInfo(
          userName: "quochuynh96 load more",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      VideoInfo(
          userName: "quochuynh96",
          liked: true,
          songName: "Đưa tay lên nào, mãi bên nhau bạn nhé!",
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
    ]);
  }
}

class TestModel extends VideoInfo {
  String test;

  TestModel(this.test);
}
