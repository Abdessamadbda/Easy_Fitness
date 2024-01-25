class Exercice {
  int id;
  String name;
  String image;
  String type;
  List<dynamic> photos;
  String get imageUrl =>
      "https://abdessamadbda.github.io/easyfitness_api/images/$image";

  String get photoUrl =>
      "https://abdessamadbda.github.io/easyfitness_api/images/$type";

  String getPhotoUrlByIndex(int index) {
    if (index >= 0 && index < photos.length) {
      return "$photoUrl/${photos[index]}";
    } else {
      return "$photoUrl/default-photo.jpg";
    }
  }

  String getPhotoName(int index) {
    if (index >= 0 && index < photos.length) {
      return "${photos[index]}";
    } else {
      return "";
    }
  }

  Exercice({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.photos,
  });

  factory Exercice.fromJson(Map<String, dynamic> json) {
    return Exercice(
      id: json['id'] as int? ?? 0, // Use a default value if 'id' is null
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      type: json['type'] as String? ?? '',
      photos: (json['photos'] as List<dynamic>?)
              ?.map((photo) => photo as String)
              .toList() ??
          [],
    );
  }
}

class Category {
  String name;
  List<Exercice> exercices;

  Category({
    required this.name,
    required this.exercices,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var exercicesJson = json['exercices'] as Iterable<dynamic>?;

    // Check if 'exercisesJson' is not null before proceeding
    var exercices =
        exercicesJson?.map((e) => Exercice.fromJson(e)).toList() ?? [];

    return Category(name: json['name'] as String, exercices: exercices);
  }
}

class ItemInCart {
  Exercice exercice;
  String detail;

  ItemInCart({required this.exercice, required this.detail});
}
