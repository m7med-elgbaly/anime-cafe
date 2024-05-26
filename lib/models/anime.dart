class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final List<String> genres;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.genres,
  });

  factory Anime.formJson(Map<String, dynamic> json) {
    List<String> genresList = [];
    if (json['genres'] != null) {
      genresList =
          List<String>.from(json['genres'].map((genre) => genre['name']));
    }
    return Anime(
        id: json['id'] ?? 0,
        title: json['title'],
        imageUrl: json['main_picture']['large'],
        rating: json['rating']?.toDouble() ?? 0.0,
        genres: genresList);
  }
}
