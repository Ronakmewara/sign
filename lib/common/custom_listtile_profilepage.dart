import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.text, required this.icon, required this.onPress, required this.endIcon});
  final String text;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        onTap: onPress,
        leading:   CircleAvatar(
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Icon(icon, color: Colors.blue, size: 28,)),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child:  Text(text, style: const TextStyle(fontWeight: FontWeight.bold),),
        ),
        trailing: endIcon ? CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.1) ,
          child: const Icon(Icons.arrow_forward_ios_rounded , color: Colors.grey, size: 18,)) : null,
        ),
      );

  }
}
