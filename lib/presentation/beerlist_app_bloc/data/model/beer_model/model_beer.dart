
import 'dart:convert';

class Beer{
  int? id;
  String? name;
  String? firstBrewed;
  String? description;
  String? imageUrl;
  Volume? volume;
  String? tagLine;
  int? ph;
  int? ibu;
  bool isFav = false;

  Beer({this.id , this.name , this.firstBrewed , this.description , this.imageUrl , this.volume , this.tagLine , this.ph , this.ibu});

  Beer.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    firstBrewed = json['first_brewed'];
    imageUrl = json['image_url'];
    volume = json['volume'] != null ? Volume.fromJson(json['volume']) : null;
    tagLine = json['tagline'];
     ph = json['ph']?.toInt();
     description = json['description'];
    ibu = json['ibu']?.toInt();

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'first_brewed': firstBrewed,
      'image_url': imageUrl,
      'volume': volume?.toJson(),
      'tagline': tagLine,
      'ph': ph,
      'description': description,
      'ibu': ibu,

    };
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}