class MyPostInListModel {
  final String postTime;
  final String createdAt;

  MyPostInListModel({required this.postTime, required this.createdAt});

  factory MyPostInListModel.fromJson(Map<String, dynamic> json) {
    return MyPostInListModel(
      postTime: json['postId'],
      createdAt: json['createdAt'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postTime;
    data['createdAt'] = createdAt;
    return data;
  }
}
