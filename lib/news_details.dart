import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  final String title;
  final String image;
  final String desc;
  final String url;
  const NewsDetails(
      {super.key,
      required this.title,
      required this.image,
      required this.desc,
      required this.url});
  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: NewsDetailsWidget(
          titl: widget.title,
          image: widget.image,
          description: widget.desc,
          url: widget.url,
        ),
      ),
    );
  }
}

class NewsDetailsWidget extends StatelessWidget {
  const NewsDetailsWidget({
    super.key,
    required this.titl,
    required this.image,
    required this.url,
    required this.description,
  });

  final String titl;
  final String image;
  final String url;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titl,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Image.network(
            image,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse(url));
            },
            child: Text('View full article'),
          ),
        ],
      ),
    );
  }
}
