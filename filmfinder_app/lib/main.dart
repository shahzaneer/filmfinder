import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/routes/route_names.dart';
import 'package:filmfinder_app/routes/routes.dart';
import 'package:filmfinder_app/utils/coloors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

void main() async {
  // Load .env file
  await dotenv.load(fileName: ".env");
  // Initialize the Flutter Widgets Bindings
  WidgetsFlutterBinding.ensureInitialized();
  // Make a directory for hive Data
  var directory = await getApplicationDocumentsDirectory();
  // Initialize hive
  Hive.init(directory.path);
  // You have to register that generated adapter
  Hive.registerAdapter(MovieModelAdapter());
  // Open a box (yeh aik database hai)
  await Hive.openBox<MovieModel>('movies');
//  Local Storage for FastCachedImage (it is also using Hive)
  String storageLocation = (await getApplicationDocumentsDirectory()).path;
  await FastCachedImageConfig.init(
      subDir: storageLocation, clearCacheAfter: const Duration(days: 15));
  //! For Device Orientation Support
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
      theme: Coolors.filmFinderTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.movieDetails,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
