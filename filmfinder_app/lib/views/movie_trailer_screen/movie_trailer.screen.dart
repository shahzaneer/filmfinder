import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/genere_tag.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class MovieTrailerScreen extends StatefulWidget {
  final MovieModel movie;
  const MovieTrailerScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieTrailerScreen> createState() => _MovieTrailerScreenState();
}

class _MovieTrailerScreenState extends State<MovieTrailerScreen> {
  bool playTrailer = false;
  var videoKey = "";
  List<GenereTag> genereList = [];

  @override
  void initState() {
    super.initState();
  }

  void showTrailer() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    videoKey = await movieProvider.getMovieTrailer(widget.movie.id);

    bool internetConnection = await InternetConnectionChecker().hasConnection;

    if (internetConnection) {
      setState(() {
        playTrailer = true;
      });
    } else {
      Utils.showErrorToast("Internet k Bagair Video kese chalegi bhai?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 0,
        title: const Text(
          'Trailer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TrailerPlayer(
              movieID: widget.movie.id,
            ),
            Divider(
              color: Colors.grey.shade50,
              thickness: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
