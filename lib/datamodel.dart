class Exercice {
  int id;
  String name;
  String image;
  String type;
  String ex1;
  String ex2;
  String ex3;
  String ex4;
  String detail1;
  String detail2;
  String detail3;
  String detail4;
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

  String getExByIndex(int index) {
    if (index == 0) {
      return "$ex1";
    } else if (index == 1) {
      return "$ex2";
    } else if (index == 2) {
      return "$ex3";
    } else if (index == 3) {
      return "$ex4";
    } else {
      return "";
    }
  }

  String getDetailByIndex(int index) {
    if (index == 0) {
      return "$detail1";
    } else if (index == 1) {
      return "$detail2";
    } else if (index == 2) {
      return "$detail3";
    } else if (index == 3) {
      return "$detail4";
    } else {
      return "";
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
    required this.ex1,
    required this.ex2,
    required this.ex3,
    required this.ex4,
    required this.detail1,
    required this.detail2,
    required this.detail3,
    required this.detail4,
    required this.photos,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'type': type,
      'ex1': ex1,
      'ex2': ex2,
      'ex3': ex3,
      'ex4': ex4,
      'detail1': detail1,
      'detail2': detail2,
      'detail3': detail3,
      'detail4': detail4,
      'photos': photos,
    };
  }

  factory Exercice.fromJson(Map<String, dynamic> json) {
    return Exercice(
      id: json['id'] as int? ?? 0, // Use a default value if 'id' is null
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      type: json['type'] as String? ?? '',
      ex1: json['ex1'] as String? ?? '',
      ex2: json['ex2'] as String? ?? '',
      ex3: json['ex3'] as String? ?? '',
      ex4: json['ex4'] as String? ?? '',
      detail1: json['detail1'] as String? ?? '',
      detail2: json['detail2'] as String? ?? '',
      detail3: json['detail3'] as String? ?? '',
      detail4: json['detail4'] as String? ?? '',
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
