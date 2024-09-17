class CatBreed {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  CatBreed({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    return CatBreed(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image']['url'],
    );
  }
}
