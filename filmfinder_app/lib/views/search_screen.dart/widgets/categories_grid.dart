import 'package:filmfinder_app/views/search_screen.dart/widgets/cateogry.dart';
import 'package:flutter/material.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0, //Horizontal Spacing
      crossAxisSpacing: 10.0, //Vertical Spacing
      children: const [
        Category(
          path: "assets/comedy.png",
          name: "Comedy",
        ),
        Category(path: "assets/crime.png", name: "Crime"),
        Category(path: "assets/documentaries.png", name: "Documentaries"),
        Category(path: "assets/dramas.png", name: "Dramas"),
        Category(path: "assets/family.png", name: "Family"),
        Category(path: "assets/fantasy.png", name: "Fantasy"),
        Category(path: "assets/holidays.png", name: "Holidays"),
        Category(path: "assets/horror.png", name: "Horror"),
        Category(path: "assets/scifi.png", name: "Sci-Fi"),
        Category(path: "assets/thriller.png", name: "Thriller"),
      ],
    );
  }
}
