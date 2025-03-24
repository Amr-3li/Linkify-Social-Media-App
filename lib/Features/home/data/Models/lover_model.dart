class LoverModel {
  final String id;
  final String name;
  final String image;
  LoverModel({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory LoverModel.fromMap(Map<String, dynamic> map) {
    return LoverModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
