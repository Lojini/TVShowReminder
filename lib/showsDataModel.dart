class ShowsDataModel {
  final Map<String, dynamic> data;
  final String id;
  final String name;
  final int country;
  final double network;
  final String status;
  final String image_thumbnail_path;

  ShowsDataModel({this.data,
    this.id,
    this.name,
    this.country,
    this.network,
    this.status,
    this.image_thumbnail_path});


  factory ShowsDataModel.fromJson(Map<String, dynamic> json) {
    return ShowsDataModel(
      data: {
        'id': json['id'],
        'name': json['name'],
        'country': json['country'],
        'network': json['network'],
        'status': json['status'],
        'image_thumbnail_path': json['image_thumbnail_path'],
      },
    );
  }

}