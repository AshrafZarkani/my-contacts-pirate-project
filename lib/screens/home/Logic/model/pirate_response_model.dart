import 'package:equatable/equatable.dart';


class PirateResponseModel extends Equatable{
  late final Data data;

  PirateResponseModel({required this.data});

  PirateResponseModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.toJson();
    return data;
  }

  @override
  List<Object> get props => [data];

  @override
  bool get stringify => false;
}

class Data extends Equatable{
   late final List<Images> images;

  Data({required this.images});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images.map((v) => v.toJson()).toList();
    return data;
  }
  @override
  List<Object> get props => [images];

  @override
  bool get stringify => false;
}

class Images extends Equatable {
  late  final bool pirate;
  late  final String url;

  Images({required this.pirate, required this.url});

  Images.fromJson(Map<String, dynamic> json) {
    pirate = json['pirate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pirate'] = this.pirate;
    data['url'] = this.url;
    return data;
  }

  @override
  List<Object> get props => [pirate, url];

  @override
  bool get stringify => false;
}