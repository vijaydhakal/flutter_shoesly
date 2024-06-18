import 'package:equatable/equatable.dart';
import 'package:shoesly/feature/product/model/product_model.dart';

/// Cart item model
class CartItemModel extends Equatable {
  /// Cart item id
  final int id;

  /// Product Id
  final String productId;

  /// Product quantity in the cart
  final int quantity;

  /// Product price * quantity
  final double price;

  /// Product size
  final int size;

  /// Product info, only use in client side
  final Product productInfo;

  /// Constructor
  CartItemModel({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.size,
    required this.productInfo,
  });

  /// Json data from server turns into model data
  static CartItemModel fromMap(String id, Map<String, dynamic> data) {
    return CartItemModel(
      id: data["id"] ?? "",
      productId: data["productId"],
      price: data["price"],
      quantity: data["quantity"] ?? 0,
      size: data["size"] ?? 0,
      productInfo: Product.fromMap(data['productInfo']),
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "productId": this.productId,
      "price": this.price,
      "quantity": this.quantity,
      "size": this.size,
      'productInfo': this.productInfo?.toJson(),
    };
  }

  /// Clone and update
  CartItemModel cloneWith({
    int? id,
    String? productId,
    Product? productInfo,
    double? price,
    int? quantity,
    int? size,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productInfo: productInfo ?? this.productInfo,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props =>
      [id, quantity, price, productId, size, productInfo];
}
