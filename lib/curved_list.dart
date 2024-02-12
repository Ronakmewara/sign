import 'package:flutter/material.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({super.key,
    required this.title,
    required this.time,
    required this.icon,
    this.people,
    required this.color,
     this.nextColor,
    required this.onTap
  });

  final String title;
  final String time;
  final String? people;
  final IconData icon;
  final Color color;
  final Color? nextColor;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: nextColor,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 32,
            top: 80.0,
            bottom: 50,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  time,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  title,
                  style:const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              const Row(),
              ]),
        ),
      ),
    );
  }
}