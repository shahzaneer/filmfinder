import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //! For Device Orientation Support
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const FilmFinderApp());
  });
}

class FilmFinderApp extends StatelessWidget {
  const FilmFinderApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(
        color: Colors.deepPurple,
      ),
    );
  }
}
