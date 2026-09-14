class Product {
  int id;
  String title;
  String description;
  double price;
  double rating;
  String thumbnail;
  List<String> images;

  Product.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      price = (json['price'] as num).toDouble(),
      rating = (json['rating'] as num).toDouble(),
      thumbnail = json['thumbnail'],
      images = List<String>.from(json['images']);
}