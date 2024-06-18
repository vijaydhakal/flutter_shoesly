/// Review model
class Review {
  /// Review id
  final int id;

  /// Product id
  final int productId;

  /// Review name
  final String name;

  /// Review description
  final String description;

  /// Review rating
  final double rating;

  // Created date
  final String createdDate;

  /// Constructor
  Review({
    required this.id,
    required this.description,
    required this.name,
    required this.productId,
    required this.rating,
    required this.createdDate,
  });

  /// Json data from server turns into model data
  static Review fromMap(Map<String, dynamic> data) {
    return Review(
      id: data["id"] ?? -1,
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      rating: double.tryParse(data["rating"].toString()) ?? 0.0,
      productId: data["product_id"] ?? -1,
      createdDate: data["created_date"] ?? "",
    );
  }

  /// Clone and update a Review
  Review cloneWith({id, name, description, categoryId, rating, price, size}) {
    return Review(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating.toDouble(),
      productId: productId,
      createdDate: createdDate,
    );
  }

  //make to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "rating": rating,
      "product_id": productId,
      "created_date": createdDate
    };
  }
}
