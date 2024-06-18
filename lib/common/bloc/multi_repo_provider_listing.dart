import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/common/bloc/multi_bloc_wrapper.dart';
import 'package:shoesly/common/constant/env.dart';
import 'package:shoesly/feature/cart/repository/firebase_cart_repo.dart';
import 'package:shoesly/feature/product/product_repository/category_repo.dart';
import 'package:shoesly/feature/product/product_repository/firebase_product_repo.dart';
import 'package:shoesly/feature/reviews/repository/firebase_review_repo.dart';

class MultiRepositoryProviderListing extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiRepositoryProviderListing(
      {required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
       
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
        RepositoryProvider<FirebaseProductRepository>(
          create: (context) => FirebaseProductRepository(),
          lazy: true,
        ),
         RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepository(),
          lazy: true,
        ),
         RepositoryProvider<FirebaseCartRepository>(
          create: (context) => FirebaseCartRepository(),
          lazy: true,
        ),
         RepositoryProvider<FirebaseReviewRepository>(
          create: (context) => FirebaseReviewRepository(),
          lazy: true,
        ),
      ],
      child: MultiBlocWrapper(child: child),
    );
  }
}

class InternetCheck {
}
