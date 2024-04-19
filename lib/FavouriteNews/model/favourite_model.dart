class NewsArticle {
  final String title;
  final String description;
  final String category;
  bool isFavorite;

  NewsArticle({
    required this.title,
    required this.description,
    required this.category,
    this.isFavorite = false,
  });
}
