import 'dart:math';
import 'package:filmfinder_app/utils/coloors.dart';
import 'package:flutter/material.dart';

class GenereTag extends StatelessWidget {
  final String genereName;
  const GenereTag({
    Key? key,
    required this.genereName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = getRandomSpecificColor(Coolors.kAppBarBackgroundColor);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Chip(
        label: Text(
          genereName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: getRandomSpecificColor(color),
      ),
    );
  }

  Color getRandomSpecificColor(Color color) {
    //! My Recursive Function :))
    List<Color> genereColors = Coolors.kGenereColors;
    Random random = Random();
    int index = random.nextInt(genereColors.length);
    if (color == genereColors[index]) {
      return getRandomSpecificColor(color);
    }
    return genereColors[index];
  }
}
