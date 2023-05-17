import 'package:challenge_movieflix/main.dart';
import 'package:challenge_movieflix/screen/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailScreen extends StatelessWidget {
  final String originalTitle, posterPath, imageUrl;
  final int id;

  const DetailScreen({
    super.key,
    required this.originalTitle,
    required this.posterPath,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Future<DetailModel> detail = ApiService.getDetailMovies('movie?id=$id');

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.network(
              '$imageUrl$posterPath',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 45,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Back to list',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 280,
                    ),
                    Text(
                      originalTitle,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder(
                      future: detail,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RatingBar.builder(
                            initialRating: double.parse(
                                ((snapshot.data!.voteAverage) / 2)
                                    .toStringAsFixed(2)),
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {},
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    FutureBuilder(
                      future: detail,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '${((snapshot.data!.runtime) / 60).floor()}h ${(snapshot.data!.runtime) % 60}min  |  ${snapshot.data!.genres}',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w100,
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      'Storyline',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 22.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    FutureBuilder(
                      future: detail,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.overview,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 15.5,
                              letterSpacing: 0.8,
                              height: 1.4,
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: detail,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () async {
                                  if (snapshot.data!.homepage != '') {
                                    await launchUrlString(
                                        snapshot.data!.homepage);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ErrorPage(),
                                        ));
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 15,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.55),
                                      )
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 90),
                                    child: Text(
                                      'Buy ticket',
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
