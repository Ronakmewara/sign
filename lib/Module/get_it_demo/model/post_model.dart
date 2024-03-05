
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';
@JsonSerializable()
class PostModel{
int? id;
String? title;
String? url;

PostModel({ this.id , this.title , this.url});

factory PostModel.fromJson(Map<String , dynamic>json) => _$PostModelFromJson(json);

}