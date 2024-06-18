import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/common/util/log.dart';
import 'package:shoesly/feature/product/model/product_model.dart';

class FirebaseProductRepository {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

//store all products
  Map<int, Product> _allProductMap = {};
  Map<int, Product> get allProductmap => _allProductMap;

  _insertItemInProductMap(Product item) {
    _allProductMap[item.id] = item;
  }

  insertAllProductInMap(List<Product> product) {
    product.forEach((element) {
      _insertItemInProductMap(element);
    });
  }

  clearProduct() {
    _allProductMap.clear();
  }

  Future<DataResponse<List<Product>>> fetchProducts({
    int offset = 0,
    required int limit,
    int? categoryId,
  }) async {
    try {
      // Query with categoryId
      if (categoryId != null && categoryId > -1) {
        final res = await productCollection
            .where("category_id", isEqualTo: categoryId)
            // .orderBy('id')
            .limit(limit)
            .get();

        final _data = res.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return DataResponse.success(_data);
      }

      // Query without categoryId
      final res = await productCollection
          // .orderBy('id')
          .limit(limit)
          .get();

      final _data = res.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return DataResponse.success(_data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  //apply filter and search query
  Future<DataResponse<List<Product>>> filterProducts({
    int offset = 0,
    required int limit,
    int? categoryId,
    double? price,
    dynamic size,
  }) async {
    try {
      // Query with categoryId
      if (categoryId != null && categoryId > -1) {
        final res = await productCollection
            .where("category_id", isEqualTo: categoryId)
            .where("price", isLessThanOrEqualTo: price)
            .where("size", isEqualTo: size)

            // .orderBy('id')
            .limit(limit)
            .get();

        final _data = res.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return DataResponse.success(_data);
      }

      // Query without categoryId
      final res = await productCollection
          // .orderBy('id')
          .limit(limit)
          .get();

      final _data = res.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return DataResponse.success(_data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  ///Singleton factory
  static final FirebaseProductRepository _instance =
      FirebaseProductRepository._internal();

  factory FirebaseProductRepository() {
    return _instance;
  }

  FirebaseProductRepository._internal();
}
