import 'package:signup_page/generated/json/base/json_convert_content.dart';
import 'package:signup_page/pro_model/beer_entity.dart';

BeerEntity $BeerEntityFromJson(Map<String, dynamic> json) {
  final BeerEntity beerEntity = BeerEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    beerEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    beerEntity.name = name;
  }
  final String? tagline = jsonConvert.convert<String>(json['tagline']);
  if (tagline != null) {
    beerEntity.tagline = tagline;
  }
  final String? firstBrewed = jsonConvert.convert<String>(json['first_brewed']);
  if (firstBrewed != null) {
    beerEntity.firstBrewed = firstBrewed;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    beerEntity.description = description;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    beerEntity.imageUrl = imageUrl;
  }
  final double? abv = jsonConvert.convert<double>(json['abv']);
  if (abv != null) {
    beerEntity.abv = abv;
  }
  final double? ibu = jsonConvert.convert<double>(json['ibu']);
  if (ibu != null) {
    beerEntity.ibu = ibu;
  }
  final int? targetFg = jsonConvert.convert<int>(json['target_fg']);
  if (targetFg != null) {
    beerEntity.targetFg = targetFg;
  }
  final double? targetOg = jsonConvert.convert<double>(json['target_og']);
  if (targetOg != null) {
    beerEntity.targetOg = targetOg;
  }
  final int? ebc = jsonConvert.convert<int>(json['ebc']);
  if (ebc != null) {
    beerEntity.ebc = ebc;
  }
  final int? srm = jsonConvert.convert<int>(json['srm']);
  if (srm != null) {
    beerEntity.srm = srm;
  }
  final double? ph = jsonConvert.convert<double>(json['ph']);
  if (ph != null) {
    beerEntity.ph = ph;
  }
  final int? attenuationLevel = jsonConvert.convert<int>(
      json['attenuation_level']);
  if (attenuationLevel != null) {
    beerEntity.attenuationLevel = attenuationLevel;
  }
  final BeerVolume? volume = jsonConvert.convert<BeerVolume>(json['volume']);
  if (volume != null) {
    beerEntity.volume = volume;
  }
  final String? x = jsonConvert.convert<String>(json['x']);
  if (x != null) {
    beerEntity.x = x;
  }
  return beerEntity;
}

Map<String, dynamic> $BeerEntityToJson(BeerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['tagline'] = entity.tagline;
  data['first_brewed'] = entity.firstBrewed;
  data['description'] = entity.description;
  data['image_url'] = entity.imageUrl;
  data['abv'] = entity.abv;
  data['ibu'] = entity.ibu;
  data['target_fg'] = entity.targetFg;
  data['target_og'] = entity.targetOg;
  data['ebc'] = entity.ebc;
  data['srm'] = entity.srm;
  data['ph'] = entity.ph;
  data['attenuation_level'] = entity.attenuationLevel;
  data['volume'] = entity.volume?.toJson();
  data['x'] = entity.x;
  return data;
}

extension BeerEntityExtension on BeerEntity {
  BeerEntity copyWith({
    int? id,
    String? name,
    String? tagline,
    String? firstBrewed,
    String? description,
    String? imageUrl,
    double? abv,
    double? ibu,
    int? targetFg,
    double? targetOg,
    int? ebc,
    int? srm,
    double? ph,
    int? attenuationLevel,
    BeerVolume? volume,
    String? x,
  }) {
    return BeerEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..tagline = tagline ?? this.tagline
      ..firstBrewed = firstBrewed ?? this.firstBrewed
      ..description = description ?? this.description
      ..imageUrl = imageUrl ?? this.imageUrl
      ..abv = abv ?? this.abv
      ..ibu = ibu ?? this.ibu
      ..targetFg = targetFg ?? this.targetFg
      ..targetOg = targetOg ?? this.targetOg
      ..ebc = ebc ?? this.ebc
      ..srm = srm ?? this.srm
      ..ph = ph ?? this.ph
      ..attenuationLevel = attenuationLevel ?? this.attenuationLevel
      ..volume = volume ?? this.volume
      ..x = x ?? this.x;
  }
}

BeerVolume $BeerVolumeFromJson(Map<String, dynamic> json) {
  final BeerVolume beerVolume = BeerVolume();
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    beerVolume.value = value;
  }
  final String? unit = jsonConvert.convert<String>(json['unit']);
  if (unit != null) {
    beerVolume.unit = unit;
  }
  return beerVolume;
}

Map<String, dynamic> $BeerVolumeToJson(BeerVolume entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['unit'] = entity.unit;
  return data;
}

extension BeerVolumeExtension on BeerVolume {
  BeerVolume copyWith({
    int? value,
    String? unit,
  }) {
    return BeerVolume()
      ..value = value ?? this.value
      ..unit = unit ?? this.unit;
  }
}