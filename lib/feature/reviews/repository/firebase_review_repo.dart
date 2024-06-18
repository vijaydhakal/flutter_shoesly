import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/common/util/log.dart';
import 'package:shoesly/feature/reviews/model/review_model.dart';

class FirebaseReviewRepository {
  final CollectionReference reviewCollection =
      FirebaseFirestore.instance.collection("reviews");

// //create review
//   Future<void> createReview() async {
//     List dataList = [
//       {
//         "id": 1,
//         "product_id": 101,
//         "name": "John Doe",
//         "description":
//             "Great product! I love the color and the fit is perfect.",
//         "rating": 4.5,
//         "created_date": "2023-10-26T10:00:00.000Z"
//       },
//       {
//         "id": 2,
//         "product_id": 101,
//         "name": "Jane Smith",
//         "description": "This is a well-made shoe, comfortable and stylish.",
//         "rating": 4.0,
//         "created_date": "2023-10-25T14:30:00.000Z"
//       },
//       {
//         "id": 3,
//         "product_id": 102,
//         "name": "Alice Johnson",
//         "description":
//             "I'm very happy with this purchase. It's exactly what I was looking for.",
//         "rating": 5.0,
//         "created_date": "2023-10-24T18:15:00.000Z"
//       },
//       {
//         "id": 4,
//         "product_id": 102,
//         "name": "Bob Williams",
//         "description": "The quality is excellent and the price is reasonable.",
//         "rating": 4.0,
//         "created_date": "2023-10-23T12:45:00.000Z"
//       },
//       {
//         "id": 5,
//         "product_id": 103,
//         "name": "Charlie Brown",
//         "description":
//             "This is a great product! I would recommend it to anyone.",
//         "rating": 4.5,
//         "created_date": "2023-10-22T16:00:00.000Z"
//       },
//       {
//         "id": 6,
//         "product_id": 103,
//         "name": "David Lee",
//         "description": "I'm impressed with the durability of this product.",
//         "rating": 5.0,
//         "created_date": "2023-10-21T10:30:00.000Z"
//       },
//       {
//         "id": 7,
//         "product_id": 104,
//         "name": "Emily Carter",
//         "description": "Love the design and the comfort of this shoe.",
//         "rating": 4.0,
//         "created_date": "2023-10-20T14:15:00.000Z"
//       },
//       {
//         "id": 8,
//         "product_id": 104,
//         "name": "Frank Miller",
//         "description":
//             "This is a great value for the price. I highly recommend it.",
//         "rating": 4.5,
//         "created_date": "2023-10-19T18:45:00.000Z"
//       },
//       {
//         "id": 9,
//         "product_id": 105,
//         "name": "Grace Wilson",
//         "description": "The color is beautiful and the material is soft.",
//         "rating": 5.0,
//         "created_date": "2023-10-18T12:00:00.000Z"
//       },
//       {
//         "id": 10,
//         "product_id": 105,
//         "name": "Henry Davis",
//         "description": "This product is perfect for everyday use.",
//         "rating": 4.0,
//         "created_date": "2023-10-17T16:30:00.000Z"
//       },
//       {
//         "id": 11,
//         "product_id": 106,
//         "name": "Isabella Brown",
//         "description": "I'm very satisfied with this purchase.",
//         "rating": 4.5,
//         "created_date": "2023-10-16T10:15:00.000Z"
//       },
//       {
//         "id": 12,
//         "product_id": 106,
//         "name": "Jack Wilson",
//         "description":
//             "This is a high-quality product that I would definitely recommend.",
//         "rating": 5.0,
//         "created_date": "2023-10-15T14:45:00.000Z"
//       },
//       {
//         "id": 13,
//         "product_id": 107,
//         "name": "Katherine Smith",
//         "description": "I love the style of this shoe.",
//         "rating": 4.0,
//         "created_date": "2023-10-14T18:00:00.000Z"
//       },
//       {
//         "id": 14,
//         "product_id": 107,
//         "name": "Leo Jones",
//         "description": "This product is comfortable and durable.",
//         "rating": 4.5,
//         "created_date": "2023-10-13T12:30:00.000Z"
//       },
//       {
//         "id": 15,
//         "product_id": 108,
//         "name": "Maria Garcia",
//         "description": "This is a great value for the money.",
//         "rating": 5.0,
//         "created_date": "2023-10-12T16:15:00.000Z"
//       },
//       {
//         "id": 16,
//         "product_id": 108,
//         "name": "Nathan Rodriguez",
//         "description":
//             "I'm very happy with this purchase. It's a great product.",
//         "rating": 4.0,
//         "created_date": "2023-10-11T10:00:00.000Z"
//       },
//       {
//         "id": 17,
//         "product_id": 109,
//         "name": "Olivia Williams",
//         "description": "I love the color and the fit of this shoe.",
//         "rating": 4.5,
//         "created_date": "2023-10-10T14:30:00.000Z"
//       },
//       {
//         "id": 18,
//         "product_id": 109,
//         "name": "Peter Davis",
//         "description":
//             "This is a great product. I would definitely buy it again.",
//         "rating": 5.0,
//         "created_date": "2023-10-09T18:15:00.000Z"
//       },
//       {
//         "id": 19,
//         "product_id": 110,
//         "name": "Quinn Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 4.0,
//         "created_date": "2023-10-08T12:45:00.000Z"
//       },
//       {
//         "id": 20,
//         "product_id": 110,
//         "name": "Ryan Brown",
//         "description":
//             "This is a great product. I'm very happy with my purchase.",
//         "rating": 4.5,
//         "created_date": "2023-10-07T16:00:00.000Z"
//       },
//       {
//         "id": 21,
//         "product_id": 111,
//         "name": "Sophia Lee",
//         "description": "I love the style and the comfort of this shoe.",
//         "rating": 5.0,
//         "created_date": "2023-10-06T10:30:00.000Z"
//       },
//       {
//         "id": 22,
//         "product_id": 111,
//         "name": "Thomas Carter",
//         "description": "This product is very durable and well-made.",
//         "rating": 4.0,
//         "created_date": "2023-10-05T14:15:00.000Z"
//       },
//       {
//         "id": 23,
//         "product_id": 112,
//         "name": "Uma Wilson",
//         "description": "I'm very satisfied with this purchase.",
//         "rating": 4.5,
//         "created_date": "2023-10-04T18:45:00.000Z"
//       },
//       {
//         "id": 24,
//         "product_id": 112,
//         "name": "Victor Davis",
//         "description":
//             "This is a great product. I would recommend it to anyone.",
//         "rating": 5.0,
//         "created_date": "2023-10-03T12:00:00.000Z"
//       },
//       {
//         "id": 25,
//         "product_id": 113,
//         "name": "Wendy Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 4.0,
//         "created_date": "2023-10-02T16:30:00.000Z"
//       },
//       {
//         "id": 26,
//         "product_id": 113,
//         "name": "Xavier Brown",
//         "description": "This product is perfect for everyday use.",
//         "rating": 4.5,
//         "created_date": "2023-10-01T10:15:00.000Z"
//       },
//       {
//         "id": 27,
//         "product_id": 114,
//         "name": "Yara Lee",
//         "description": "I'm very happy with this purchase.",
//         "rating": 5.0,
//         "created_date": "2023-09-30T14:45:00.000Z"
//       },
//       {
//         "id": 28,
//         "product_id": 114,
//         "name": "Zachary Carter",
//         "description":
//             "This is a high-quality product that I would definitely recommend.",
//         "rating": 4.0,
//         "created_date": "2023-09-29T18:00:00.000Z"
//       },
//       {
//         "id": 29,
//         "product_id": 115,
//         "name": "Amelia Wilson",
//         "description": "I love the style of this shoe.",
//         "rating": 4.5,
//         "created_date": "2023-09-28T12:30:00.000Z"
//       },
//       {
//         "id": 30,
//         "product_id": 115,
//         "name": "Benjamin Davis",
//         "description": "This product is comfortable and durable.",
//         "rating": 5.0,
//         "created_date": "2023-09-27T16:15:00.000Z"
//       },
//       {
//         "id": 31,
//         "product_id": 116,
//         "name": "Chloe Garcia",
//         "description": "This is a great value for the money.",
//         "rating": 4.0,
//         "created_date": "2023-09-26T10:00:00.000Z"
//       },
//       {
//         "id": 32,
//         "product_id": 116,
//         "name": "Daniel Rodriguez",
//         "description":
//             "I'm very happy with this purchase. It's a great product.",
//         "rating": 4.5,
//         "created_date": "2023-09-25T14:30:00.000Z"
//       },
//       {
//         "id": 33,
//         "product_id": 117,
//         "name": "Eleanor Williams",
//         "description": "I love the color and the fit of this shoe.",
//         "rating": 5.0,
//         "created_date": "2023-09-24T18:15:00.000Z"
//       },
//       {
//         "id": 34,
//         "product_id": 117,
//         "name": "Frederick Davis",
//         "description":
//             "This is a great product. I would definitely buy it again.",
//         "rating": 4.0,
//         "created_date": "2023-09-23T12:45:00.000Z"
//       },
//       {
//         "id": 35,
//         "product_id": 118,
//         "name": "Gwendolyn Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 4.5,
//         "created_date": "2023-09-22T16:00:00.000Z"
//       },
//       {
//         "id": 36,
//         "product_id": 118,
//         "name": "Harold Brown",
//         "description": "This product is perfect for everyday use.",
//         "rating": 5.0,
//         "created_date": "2023-09-21T10:30:00.000Z"
//       },
//       {
//         "id": 37,
//         "product_id": 119,
//         "name": "Irene Lee",
//         "description": "I'm very happy with this purchase.",
//         "rating": 4.0,
//         "created_date": "2023-09-20T14:15:00.000Z"
//       },
//       {
//         "id": 38,
//         "product_id": 119,
//         "name": "Jacob Carter",
//         "description":
//             "This is a high-quality product that I would definitely recommend.",
//         "rating": 4.5,
//         "created_date": "2023-09-19T18:45:00.000Z"
//       },
//       {
//         "id": 39,
//         "product_id": 120,
//         "name": "Katherine Wilson",
//         "description": "I love the style of this shoe.",
//         "rating": 5.0,
//         "created_date": "2023-09-18T12:00:00.000Z"
//       },
//       {
//         "id": 40,
//         "product_id": 120,
//         "name": "Liam Davis",
//         "description": "This product is comfortable and durable.",
//         "rating": 4.0,
//         "created_date": "2023-09-17T16:30:00.000Z"
//       },
//       {
//         "id": 41,
//         "product_id": 121,
//         "name": "Maria Garcia",
//         "description": "This is a great value for the money.",
//         "rating": 4.5,
//         "created_date": "2023-09-16T10:15:00.000Z"
//       },
//       {
//         "id": 42,
//         "product_id": 121,
//         "name": "Nathan Rodriguez",
//         "description":
//             "I'm very happy with this purchase. It's a great product.",
//         "rating": 5.0,
//         "created_date": "2023-09-15T14:45:00.000Z"
//       },
//       {
//         "id": 43,
//         "product_id": 122,
//         "name": "Olivia Williams",
//         "description": "I love the color and the fit of this shoe.",
//         "rating": 4.0,
//         "created_date": "2023-09-14T18:00:00.000Z"
//       },
//       {
//         "id": 44,
//         "product_id": 122,
//         "name": "Peter Davis",
//         "description":
//             "This is a great product. I would definitely buy it again.",
//         "rating": 4.5,
//         "created_date": "2023-09-13T12:30:00.000Z"
//       },
//       {
//         "id": 45,
//         "product_id": 123,
//         "name": "Quinn Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 5.0,
//         "created_date": "2023-09-12T16:15:00.000Z"
//       },
//       {
//         "id": 46,
//         "product_id": 123,
//         "name": "Ryan Brown",
//         "description":
//             "This is a great product. I'm very happy with my purchase.",
//         "rating": 4.0,
//         "created_date": "2023-09-11T10:00:00.000Z"
//       },
//       {
//         "id": 47,
//         "product_id": 124,
//         "name": "Sophia Lee",
//         "description": "I love the style and the comfort of this shoe.",
//         "rating": 4.5,
//         "created_date": "2023-09-10T14:30:00.000Z"
//       },
//       {
//         "id": 48,
//         "product_id": 124,
//         "name": "Thomas Carter",
//         "description": "This product is very durable and well-made.",
//         "rating": 5.0,
//         "created_date": "2023-09-09T18:15:00.000Z"
//       },
//       {
//         "id": 49,
//         "product_id": 125,
//         "name": "Uma Wilson",
//         "description": "I'm very satisfied with this purchase.",
//         "rating": 4.0,
//         "created_date": "2023-09-08T12:45:00.000Z"
//       },
//       {
//         "id": 50,
//         "product_id": 125,
//         "name": "Victor Davis",
//         "description":
//             "This is a great product. I would recommend it to anyone.",
//         "rating": 4.5,
//         "created_date": "2023-09-07T16:00:00.000Z"
//       },
//       {
//         "id": 51,
//         "product_id": 126,
//         "name": "Wendy Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 5.0,
//         "created_date": "2023-09-06T10:30:00.000Z"
//       },
//       {
//         "id": 52,
//         "product_id": 126,
//         "name": "Xavier Brown",
//         "description": "This product is perfect for everyday use.",
//         "rating": 4.0,
//         "created_date": "2023-09-05T14:15:00.000Z"
//       },
//       {
//         "id": 53,
//         "product_id": 127,
//         "name": "Yara Lee",
//         "description": "I'm very happy with this purchase.",
//         "rating": 4.5,
//         "created_date": "2023-09-04T18:45:00.000Z"
//       },
//       {
//         "id": 54,
//         "product_id": 127,
//         "name": "Zachary Carter",
//         "description":
//             "This is a high-quality product that I would definitely recommend.",
//         "rating": 5.0,
//         "created_date": "2023-09-03T12:00:00.000Z"
//       },
//       {
//         "id": 55,
//         "product_id": 128,
//         "name": "Amelia Wilson",
//         "description": "I love the style of this shoe.",
//         "rating": 4.0,
//         "created_date": "2023-09-02T16:30:00.000Z"
//       },
//       {
//         "id": 56,
//         "product_id": 128,
//         "name": "Benjamin Davis",
//         "description": "This product is comfortable and durable.",
//         "rating": 4.5,
//         "created_date": "2023-09-01T10:15:00.000Z"
//       },
//       {
//         "id": 57,
//         "product_id": 129,
//         "name": "Chloe Garcia",
//         "description": "This is a great value for the money.",
//         "rating": 5.0,
//         "created_date": "2023-08-31T14:45:00.000Z"
//       },
//       {
//         "id": 58,
//         "product_id": 129,
//         "name": "Daniel Rodriguez",
//         "description":
//             "I'm very happy with this purchase. It's a great product.",
//         "rating": 4.0,
//         "created_date": "2023-08-30T18:00:00.000Z"
//       },
//       {
//         "id": 59,
//         "product_id": 130,
//         "name": "Eleanor Williams",
//         "description": "I love the color and the fit of this shoe.",
//         "rating": 4.5,
//         "created_date": "2023-08-29T12:30:00.000Z"
//       },
//       {
//         "id": 60,
//         "product_id": 130,
//         "name": "Frederick Davis",
//         "description":
//             "This is a great product. I would definitely buy it again.",
//         "rating": 5.0,
//         "created_date": "2023-08-28T16:15:00.000Z"
//       },
//       {
//         "id": 61,
//         "product_id": 131,
//         "name": "Gwendolyn Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 4.0,
//         "created_date": "2023-08-27T10:00:00.000Z"
//       },
//       {
//         "id": 62,
//         "product_id": 131,
//         "name": "Harold Brown",
//         "description": "This product is perfect for everyday use.",
//         "rating": 4.5,
//         "created_date": "2023-08-26T14:30:00.000Z"
//       },
//       {
//         "id": 63,
//         "product_id": 132,
//         "name": "Irene Lee",
//         "description": "I'm very happy with this purchase.",
//         "rating": 5.0,
//         "created_date": "2023-08-25T18:15:00.000Z"
//       },
//       {
//         "id": 64,
//         "product_id": 132,
//         "name": "Jacob Carter",
//         "description":
//             "This is a high-quality product that I would definitely recommend.",
//         "rating": 4.0,
//         "created_date": "2023-08-24T12:45:00.000Z"
//       },
//       {
//         "id": 65,
//         "product_id": 133,
//         "name": "Katherine Wilson",
//         "description": "I love the style of this shoe.",
//         "rating": 4.5,
//         "created_date": "2023-08-23T16:00:00.000Z"
//       },
//       {
//         "id": 66,
//         "product_id": 133,
//         "name": "Liam Davis",
//         "description": "This product is comfortable and durable.",
//         "rating": 5.0,
//         "created_date": "2023-08-22T10:30:00.000Z"
//       },
//       {
//         "id": 67,
//         "product_id": 134,
//         "name": "Maria Garcia",
//         "description": "This is a great value for the money.",
//         "rating": 4.0,
//         "created_date": "2023-08-21T14:15:00.000Z"
//       },
//       {
//         "id": 68,
//         "product_id": 134,
//         "name": "Nathan Rodriguez",
//         "description":
//             "I'm very happy with this purchase. It's a great product.",
//         "rating": 4.5,
//         "created_date": "2023-08-20T18:45:00.000Z"
//       },
//       {
//         "id": 69,
//         "product_id": 135,
//         "name": "Olivia Williams",
//         "description": "I love the color and the fit of this shoe.",
//         "rating": 5.0,
//         "created_date": "2023-08-19T12:00:00.000Z"
//       },
//       {
//         "id": 70,
//         "product_id": 135,
//         "name": "Peter Davis",
//         "description":
//             "This is a great product. I would definitely buy it again.",
//         "rating": 4.0,
//         "created_date": "2023-08-18T16:30:00.000Z"
//       },
//       {
//         "id": 71,
//         "product_id": 136,
//         "name": "Quinn Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 4.5,
//         "created_date": "2023-08-17T10:15:00.000Z"
//       },
//       {
//         "id": 72,
//         "product_id": 136,
//         "name": "Ryan Brown",
//         "description":
//             "This is a great product. I'm very happy with my purchase.",
//         "rating": 5.0,
//         "created_date": "2023-08-16T14:45:00.000Z"
//       },
//       {
//         "id": 73,
//         "product_id": 137,
//         "name": "Sophia Lee",
//         "description": "I love the style and the comfort of this shoe.",
//         "rating": 4.0,
//         "created_date": "2023-08-15T18:00:00.000Z"
//       },
//       {
//         "id": 74,
//         "product_id": 137,
//         "name": "Thomas Carter",
//         "description": "This product is very durable and well-made.",
//         "rating": 4.5,
//         "created_date": "2023-08-14T12:30:00.000Z"
//       },
//       {
//         "id": 75,
//         "product_id": 138,
//         "name": "Uma Wilson",
//         "description": "I'm very satisfied with this purchase.",
//         "rating": 5.0,
//         "created_date": "2023-08-13T16:15:00.000Z"
//       },
//       {
//         "id": 76,
//         "product_id": 138,
//         "name": "Victor Davis",
//         "description":
//             "This is a great product. I would recommend it to anyone.",
//         "rating": 4.0,
//         "created_date": "2023-08-12T10:00:00.000Z"
//       },
//       {
//         "id": 77,
//         "product_id": 139,
//         "name": "Wendy Miller",
//         "description": "The quality of this product is excellent.",
//         "rating": 4.5,
//         "created_date": "2023-08-11T14:30:00.000Z"
//       },
//       {
//         "id": 78,
//         "product_id": 139,
//         "name": "Xavier Brown",
//         "description": "This product is perfect for everyday use.",
//         "rating": 5.0,
//         "created_date": "2023-08-10T18:15:00.000Z"
//       },
//       {
//         "id": 79,
//         "product_id": 140,
//         "name": "Yara Lee",
//         "description": "I'm very happy with this purchase.",
//         "rating": 4.0,
//         "created_date": "2023-08-09T12:45:00.000Z"
//       },
//       {
//         "id": 80,
//         "product_id": 140,
//         "name": "Zachary Carter",
//         "description":
//             "This is a high-quality product that I would definitely recommend.",
//         "rating": 4.5,
//         "created_date": "2023-08-08T16:00:00.000Z"
//       },
//       {
//         "id": 81,
//         "product_id": 141,
//         "name": "Amelia Wilson",
//         "description": "I love the style of this shoe.",
//         "rating": 5.0,
//         "created_date": "2023-08-07T10:30:00.000Z"
//       },
//       {
//         "id": 82,
//         "product_id": 141,
//         "name": "Benjamin Davis",
//         "description": "This product is comfortable and durable.",
//         "rating": 4.0,
//         "created_date": "2023-08-06T14:15:00.000Z"
//       },
//       {
//         "id": 83,
//         "product_id": 142,
//         "name": "Chloe Garcia",
//         "description": "This is a great value for the money.",
//         "rating": 4.5,
//         "created_date": "2023-08-05T18:45:00.000Z"
//       },
//       {
//         "id": 84,
//         "product_id": 142,
//         "name": "Daniel Rodriguez",
//         "description":
//             "I'm very happy with this purchase. It's a great product.",
//         "rating": 5.0,
//         "created_date": "2023-08-04T12:00:00.000Z"
//       },
//       {
//         "id": 85,
//         "product_id": 143,
//         "name": "Eleanor Williams",
//         "description": "I love the color and the fit of this shoe.",
//         "rating": 4.0,
//         "created_date": "2023-08-03T16:30:00.000Z"
//       },
//       {
//         "id": 86,
//         "product_id": 143,
//         "name": "Frederick Davis",
//         "description":
//             "This is a great product. I would definitely buy it again.",
//         "rating": 4.5,
//       }
//     ];
//     Random random = Random();

//     for (int i = 0; i < dataList.length; i++) {
//       final res = await reviewCollection.add({
//         "id": dataList[i]['id'],
//         "product_id": dataList[i]['id'],
//         "name": dataList[i]['name'],
//         "description": dataList[i]['description'],
//         "rating": random.nextInt(5) + 1,
//         "created_date": dataList[i]['created_date'],
//       });
//     }
//   }

//store all Reviews
  Map<int, Review> _allReviewMap = {};
  Map<int, Review> get allReviewmap => _allReviewMap;

  _insertItemInReviewMap(Review item) {
    _allReviewMap[item.id] = item;
  }

  insertAllReviewInMap(List<Review> item) {
    item.forEach((element) {
      _insertItemInReviewMap(element);
    });
  }

  clearReview() {
    _allReviewMap.clear();
  }

  Future<DataResponse<List<Review>>> fetchReviews({
    int offset = 0,
    required int limit,
    double? rating,
   required int productId,
  }) async {
    try {
      // Query with rating
      if (rating != null && rating > -1) {
        final res = await reviewCollection
            .where("rating", isEqualTo: rating)
          // .where('product_id', isEqualTo: productId)
            // .orderBy('id')
            .limit(limit)
            .get();

        final _data = res.docs
            .map((doc) => Review.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        return DataResponse.success(_data);
      }

      // Query without rating
      final res = await reviewCollection
          //  .where('product_id', isEqualTo: productId)
          .limit(limit)
          .get();

      final _data = res.docs
          .map((doc) => Review.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return DataResponse.success(_data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  ///Singleton factory
  static final FirebaseReviewRepository _instance =
      FirebaseReviewRepository._internal();

  factory FirebaseReviewRepository() {
    return _instance;
  }

  FirebaseReviewRepository._internal();
}
