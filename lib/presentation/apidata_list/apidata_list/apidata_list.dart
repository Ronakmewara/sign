import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/router_constants.dart';
import '../../../theme/theme.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({super.key, required this.filteredPosts});
final List filteredPosts;

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 2),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  context.go( RouterConstants.apiDataDetails , extra: post);
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             DetailsPage(post: post)));
                },
                leading: CircleAvatar(
                    backgroundColor: buttonLightGreen,
                    maxRadius: 40,
                    child: Text(
                      post.id.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    )),
                title: Text(
                  post.title!,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 17),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
    );
  }
}
