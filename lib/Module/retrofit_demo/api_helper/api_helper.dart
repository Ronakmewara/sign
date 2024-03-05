
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_helper.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestClient{
factory RestClient(Dio dio) = _RestClient;

@GET("/posts")
  Future<List<PostModel>> getPosts();
}

@JsonSerializable()
class PostModel{
  int id;
  String title;
  String body;

  PostModel({required this.id , required this.body , required this.title});

  factory PostModel.fromJson(Map<String , dynamic> json) => _$PostModelFromJson(json);
}
