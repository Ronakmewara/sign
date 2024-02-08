
import 'dart:convert';

class Beer{
  int? id;
  String? name;
  String? firstBrewed;
  String? description;
  String? imageUrl;
  Volume? volume;
  String? tagLine;
  double? ph;

  Beer({this.id , this.name , this.firstBrewed , this.description , this.imageUrl , this.volume , this.tagLine , this.ph});

  Beer.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    firstBrewed = json['first_brewed'];
    imageUrl = json['image_url'];
    volume = json['volume'] != null ? Volume.fromJson(json['volume']) : null;
    tagLine = json['tagline'];
     ph = json['ph'];
  }



  }




class Volume {
  int? value;
  String? unit;

  Volume({this.value, this.unit});

  Volume.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}