import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/FavouriteNews/cubit/favourite_news_cubit.dart';
import 'package:news_weather/news/models/news_model.dart';
import 'package:news_weather/news/view/news_view.dart';

import '../../news_details.dart';

class FavoriteNewsWidget extends StatefulWidget {
  const FavoriteNewsWidget({
    super.key,
  });

  @override
  State<FavoriteNewsWidget> createState() => _FavoriteNewsWidgetState();
}

class _FavoriteNewsWidgetState extends State<FavoriteNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<FavouriteNewsCubit, NewsDataModel>(
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
