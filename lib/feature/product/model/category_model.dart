import 'package:equatable/equatable.dart';

/// CategoryModel model
class CategoryModel extends Equatable {
  final int id;
  final String title;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  /// Json data from server turns into model data
  static CategoryModel fromMap(String id, Map<String, dynamic> data) {
    return CategoryModel(
      id: data["id"] ?? "",
      title: data["title"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.title,
      "imageUrl": this.imageUrl,
    };
  }

  @override
  String toString() {
    return this.title;
  }

  @override
  List<Object?> get props => [this.id, this.title, this.imageUrl];
}
