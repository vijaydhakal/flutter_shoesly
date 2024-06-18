import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/common/util/get_device_id.dart';
import 'package:shoesly/common/util/log.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';


class FirebaseCartRepository {
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection("cart");

  Map<int, CartItemModel> _allCartsMap = {};
  Map<int, CartItemModel> get allCartmap => _allCartsMap;

  GetDeviceId getDeviceId = GetDeviceId();

  _insertItemInCartMap(CartItemModel item) {
    _allCartsMap[item.id] = item;
  }

  insertAllCartInMap(List<CartItemModel> item) {
    item.forEach((element) {
      _insertItemInCartMap(element);
    });
  }

  /// Get all cart items
  Future<DataResponse<List<CartItemModel>>> fetchCart({
    int offset = 0,
    required int limit,
  }) async {
    try {
      final String deviceId = await getDeviceId.getId();

      return cartCollection
          .doc(deviceId)
          .collection("cart")
          .limit(limit)
          .orderBy('id')
          .get()
          .then((value) {
        final _data = value.docs
            .map((doc) => CartItemModel.fromMap(
                doc.id, doc.data() as Map<String, dynamic>))
            .toList();
        return DataResponse.success(_data);
      });

      // final _data = res.docs
      //     .map((doc) =>
      //         CartItemModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
      //     .toList();
      // return DataResponse.success(_data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  /// Add item
  Future<DataResponse> addCartItemModel(CartItemModel newItem) async {
    try {
      final String deviceId = await getDeviceId.getId();
      var ref = cartCollection.doc(deviceId);

      return ref
          .collection("cart")
          .doc(newItem.id.toString())
          .get()
          .then((doc) async {
        if (doc.exists) {
          // old data + new data
          var quantity = doc.data()!["quantity"] + newItem.quantity;
          var price = doc.data()!["price"] + newItem.price;
          // update
          await doc.reference.update({"quantity": quantity, "price": price});
        } else {
          // add new
          await doc.reference.set(newItem.toMap());
        }
        return DataResponse.success(newItem);
      });
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  /// Remove item

  Future<DataResponse> removeCartItemModel({required int cartId}) async {
    try {
      final String deviceId = await getDeviceId.getId();

      final res = await cartCollection
          .doc(deviceId)
          .collection("cart")
          .doc(cartId.toString())
          .delete();

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  /// Clear cart

  Future<DataResponse> clearCart() async {
    try {
      final String deviceId = await getDeviceId.getId();
      return cartCollection
          .doc(deviceId)
          .collection("cart")
          .get()
          .then((snapshot) async {
        for (DocumentSnapshot doc in snapshot.docs) {
          await doc.reference.delete();
        }

        return DataResponse.success(true);
      });
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }


  Future<DataResponse> updateCartItemModel(CartItemModel cartItem) async {
    try {
      final String deviceId = await getDeviceId.getId();
      var userRef = cartCollection.doc(deviceId);
      return await userRef
          .collection("cart")
          .doc(cartItem.id.toString())
          .get()
          .then((doc) async {
        if (doc.exists) {
          await doc.reference.update(cartItem.toMap());
        }
        return DataResponse.success(true);
      });
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  ///Singleton factory
  static final FirebaseCartRepository _instance =
      FirebaseCartRepository._internal();

  factory FirebaseCartRepository() {
    return _instance;
  }

  FirebaseCartRepository._internal();
}
