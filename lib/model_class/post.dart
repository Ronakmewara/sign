

class Post{
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId , this.id , this.title , this.body});

  Post.fromJson(Map<String , dynamic> json){
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
 // to convert the List to json (why we write these types of method here ??)

  Map<String , dynamic> toJson(){
    return {
      'userId' : userId,
      'id': id,
      'title': title,
      'body': body,
    };

  }

}