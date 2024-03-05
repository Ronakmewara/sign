import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:signup_page/Module/get_it_demo/locator.dart';
import 'package:signup_page/Module/get_it_demo/model/post_model.dart';
import 'package:signup_page/Module/get_it_demo/repo/post_repo.dart';

class ShowPostWithGetIt extends StatefulWidget {
  const ShowPostWithGetIt({super.key});

  @override
  State<ShowPostWithGetIt> createState() => _ShowPostWithGetItState();
}

class _ShowPostWithGetItState extends State<ShowPostWithGetIt> {
  PostModel? post;
  int page = 1;

  Future<void> _getPost() async {

    PostModel newPost = await locator.get<PostRepo>().getPosts(page);
    setState(() {
      post = newPost;
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Get It Demo',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: post == null
          ? const Center(child: Text('No Post Available'))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '""${post?.title ?? ""}""',
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      height: 100,
                      width: 100,
                      child: Image.network(post?.url ?? ""))
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPost,
        tooltip: "showPost",
        child: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
