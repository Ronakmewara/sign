import 'dart:convert';

import '../model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepo{

  Future<PostModel> getPosts(page)async{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos/$page"));
    var post = jsonDecode(response.body);
    return PostModel.fromJson(post);

  }

}