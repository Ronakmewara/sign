import 'package:signup_page/generated/json/base/json_field.dart';
import 'package:signup_page/generated/json/beer_entity.g.dart';
import 'dart:convert';
export 'package:signup_page/generated/json/beer_entity.g.dart';

@JsonSerializable()
class BeerEntity {
	int? id;
	String? name;
	String? tagline;
	@JSONField(name: "first_brewed")
	String? firstBrewed;
	String? description;
	@JSONField(name: "image_url")
	String? imageUrl;
	double? abv;
	double? ibu;
	@JSONField(name: "target_fg")
	int? targetFg;
	@JSONField(name: "target_og")
	double? targetOg;
	int? ebc;
	int? srm;
	double? ph;
	@JSONField(name: "attenuation_level")
	int? attenuationLevel;
	BeerVolume? volume;
	String? x;

	BeerEntity();

	factory BeerEntity.fromJson(Map<String, dynamic> json) => $BeerEntityFromJson(json);

	Map<String, dynamic> toJson() => $BeerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BeerVolume {
	int? value;
	String? unit;

	BeerVolume();

	factory BeerVolume.fromJson(Map<String, dynamic> json) => $BeerVolumeFromJson(json);

	Map<String, dynamic> toJson() => $BeerVolumeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}