import 'package:flutter/material.dart';
import '../apidata_details/apidata_details.dart';
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(post: post)));
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
