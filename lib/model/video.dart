class VideoInfo {
  String? url;
  String? userName;
  String? songName;
  String? category;
  bool? liked;
  int? numberOfLikes;
  int? numberOfViews;
  DateTime? uploadTime;
  String? location;
  List<String>? hashtags;

  VideoInfo(
      {this.url,
      this.userName,
      this.songName,
      this.liked,
      this.category,
      this.numberOfViews,
      this.numberOfLikes,
      this.location,
      this.uploadTime,
      this.hashtags});
}
