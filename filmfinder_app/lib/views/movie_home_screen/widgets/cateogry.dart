// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  String path;
  String name;

  Category({
    Key? key,
    required this.path,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.01,
      child: Stack(
        children: [
          Image.asset(path),
          Positioned(
            left: 5,
            top: 55,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
