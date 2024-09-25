import 'package:equatable/equatable.dart';

class Meme extends Equatable {
  Meme({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
    this.captions,
  });

  Meme.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    boxCount = json['box_count'];
    captions = json['captions'];
  }

  String? id;
  String? name;
  String? url;
  int? width;
  int? height;
  int? boxCount;
  int? captions;

  Meme copyWith({
    String? id,
    String? name,
    String? url,
    int? width,
    int? height,
    int? boxCount,
    int? captions,
  }) =>
      Meme(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        width: width ?? this.width,
        height: height ?? this.height,
        boxCount: boxCount ?? this.boxCount,
        captions: captions ?? this.captions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    map['box_count'] = boxCount;
    map['captions'] = captions;
    return map;
  }

  @override
  String toString() {
    return 'Meme{id: $id, name: $name, url: $url, width: $width, height: $height, boxCount: $boxCount, captions: $captions}';
  }

  @override
  List<Object> get props => [id!];
}
