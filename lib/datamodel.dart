class Exercice {
  int id;
  String name;
  String image;
  String get imageUrl =>
      "https://abdessamadbda.github.io/easyfitness_api/images/$image";

  Exercice({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Exercice.fromJson(Map<String, dynamic> json) {
    return Exercice(
        id: json['id'] as int,
        name: json['name'] as String,
        image: json['image'] as String);
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
    var exercicesJson = json['exercises'] as Iterable<dynamic>;
    var exercices = exercicesJson.map((e) => Exercice.fromJson(e)).toList();
    return Category(name: json['name'] as String, exercices: exercices);
  }
}

class ItemInCart {
  Exercice exercice;
    String detail;

  ItemInCart({
    required this.exercice,
    required this.detail
  });

  
}