/// Product model
class Product {
  /// Product id
  final int id;

  /// CategoryModel id
  final int categoryId;

  /// Product name
  final String name;

  /// Product description
  final String description;

  /// Product rating
  final double rating;

  final double price;

  final List<dynamic> size;

  /// Constructor
  Product({
    required this.id,
    required this.description,
    required this.name,
    required this.categoryId,
    required this.rating,
    required this.price,
    required this.size,
  });

  /// Json data from server turns into model data
  static Product fromMap(Map<String, dynamic> data) {
    return Product(
      id: data["id"] ?? -1,
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      categoryId: data["category_id"] ?? -1,
      rating: data["rating"] ?? 0.0,
      price: data["price"] ?? 1,
      size: data["size"] ?? [],
    );
  }

  /// Clone and update a product
  Product cloneWith({id, name, description, categoryId, rating, price, size}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      size: size ?? this.size,
    );
  }

  //make to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "category_id": categoryId,
      "rating": rating,
      "price": price,
      "size": size,
    };
  }
}
