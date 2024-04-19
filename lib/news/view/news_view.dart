import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/FavouriteNews/cubit/favourite_news_cubit.dart';
import 'package:news_weather/FavouriteNews/views/favourite_news_view.dart';
import 'package:news_weather/news/models/news_model.dart';
import 'package:news_weather/news_details.dart';
import 'package:news_weather/settings_screen.dart';
import 'package:news_weather/weather/cubit/weather_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/nav_cubit.dart';
import '../cubit/news_cubit.dart';

List<Widget> _pages = <Widget>[
  AllNewsWidget(),
  FavoriteNewsWidget(),
  SavedNewsWidget(),
];

class NewsView extends StatefulWidget {
  final String cityname;
  const NewsView({super.key, required this.cityname});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewsCubit>().storeNews();
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavouriteNewsCubit>().storeNews();
    });
    _loadWeather();
    super.initState();
  }

  String greetUser() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Future<String> getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? "No name";
  }

  Future<void> _loadWeather() async {
    context.read<WeatherCubit>().getWeather(widget.cityname);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, navBarState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            title: FutureBuilder<String>(
              future: getStringValues(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("");
                } else {
                  return Text(greetUser() + ", " + snapshot.requireData);
                }
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: BlocBuilder<WeatherCubit, String>(
                builder: (context, state) {
                  return state.isEmpty
                      ? Text("")
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        );
                },
              ),
            ),
          ),
          body: _pages[navBarState],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              context.read<NavBarCubit>().updateIndex(index);
            },
            indicatorColor: Theme.of(context).colorScheme.inversePrimary,
            selectedIndex: navBarState,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.newspaper),
                icon: Icon(Icons.newspaper_outlined),
                label: 'All News',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.bookmark),
                label: 'Saved News',
              ),
            ],
          ),
        );
      },
    );
  }
}

class AllNewsWidget extends StatelessWidget {
  const AllNewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<NewsCubit, NewsDataModel>(
        builder: (context, state) {
          return state.status == 'initial'
              ? Text('No news Items')
              : ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetails(
                              title: state.articles[index].title,
                              desc: state.articles[index].description ??
                                  "No Description",
                              image: state.articles[index].urlToImage ??
                                  "https://t3.ftcdn.net/jpg/05/52/37/18/360_F_552371867_LkVmqMEChRhMMHDQ2drOS8cwhAWehgVc.jpg",
                              url: state.articles[index].url,
                            ),
                          ),
                        );
                      },
                      child: NewsItem(
                        title: state.articles[index].title,
                        image: state.articles[index].urlToImage ??
                            "https://t3.ftcdn.net/jpg/05/52/37/18/360_F_552371867_LkVmqMEChRhMMHDQ2drOS8cwhAWehgVc.jpg",
                        url: state.articles[index].url,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

class SavedNewsWidget extends StatelessWidget {
  const SavedNewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Your Saved News here'),
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.title,
    required this.image,
    required this.url,
  });

  final String title;
  final String image;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 100, // Set the desired width
        height: 100, // Set the desired height
        child: Image.network(image),
      ),
      title: Text(title),
    );
  }
}
