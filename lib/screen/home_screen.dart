import 'package:challenge_movieflix/main.dart';
import 'package:challenge_movieflix/screen/detail_screen.dart';
import 'package:challenge_movieflix/widget/home_title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String imageUrl = "https://image.tmdb.org/t/p/w500";

  Future<List<HomeModel>> populars = ApiService.getHomeMovies('popular');
  Future<List<HomeModel>> nowPlaying = ApiService.getHomeMovies('now-playing');
  Future<List<HomeModel>> comingSoon = ApiService.getHomeMovies('coming-soon');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Text(
                  'Movie Flix',
                  style: TextStyle(
                    fontFamily: 'TiltPrism',
                    color: Theme.of(context).primaryColor,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const HomeTitle(
                  title: 'Popular Movies',
                  lineWidth: 152,
                ),
                FutureBuilder(
                  future: populars,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 275,
                        child: makeListView(
                          snapshot: snapshot,
                          imageWidth: 300,
                          imageHeight: 230,
                          isTitle: false,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Column(
                  children: const [
                    HomeTitle(
                      title: 'Now in Cinemas',
                      lineWidth: 156,
                    ),
                  ],
                ),
                FutureBuilder(
                  future: nowPlaying,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 215,
                        child: makeListView(
                          snapshot: snapshot,
                          imageWidth: 110,
                          imageHeight: 120,
                          isTitle: true,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Column(
                  children: const [
                    HomeTitle(
                      title: 'Coming soon',
                      lineWidth: 132,
                    ),
                  ],
                ),
                FutureBuilder(
                  future: comingSoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 215,
                        child: makeListView(
                          snapshot: snapshot,
                          imageWidth: 110,
                          imageHeight: 120,
                          isTitle: true,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView makeListView({
    required AsyncSnapshot<List<HomeModel>> snapshot,
    required double imageWidth,
    required double imageHeight,
    required bool isTitle,
  }) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var getData = snapshot.data![index];
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        originalTitle: getData.originalTitle,
                        posterPath: getData.posterPath,
                        imageUrl: imageUrl,
                        id: getData.id,
                      ),
                    ));
              },
              child: Container(
                width: imageWidth,
                height: imageHeight,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  '$imageUrl${getData.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 100,
              child: Text(
                isTitle ? getData.originalTitle : '',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Theme.of(context).canvasColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
    );
  }
}
