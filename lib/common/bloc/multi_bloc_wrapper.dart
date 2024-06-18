import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/feature/cart/cubit/cart_list_cubit.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_cubit.dart';
import 'package:shoesly/feature/cart/repository/firebase_cart_repo.dart';
import 'package:shoesly/feature/product/cubit/category_cubit.dart';
import 'package:shoesly/feature/product/cubit/product_cubit.dart';
import 'package:shoesly/feature/product/product_repository/category_repo.dart';
import 'package:shoesly/feature/product/product_repository/firebase_product_repo.dart';
import 'package:shoesly/feature/reviews/cubit/review_cubit.dart';
import 'package:shoesly/feature/reviews/repository/firebase_review_repo.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ProductCubit(
              firebaseProductRepository:
                  RepositoryProvider.of<FirebaseProductRepository>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return CategoryCubit(
              categoryRepository: RepositoryProvider.of<CategoryRepository>(context),
            );
          },
        ),
         BlocProvider(
          create: (context) {
            return CartUpdateCubit(
              cartRepository: RepositoryProvider.of<FirebaseCartRepository>(context),
            );
          },
        ),
         BlocProvider(
          create: (context) {
            return CartListCubit(
              cartRepository: RepositoryProvider.of<FirebaseCartRepository>(context),
            );
          },
        ),
         BlocProvider(
          create: (context) {
            return ReviewCubit(
              firebaseReviewRepository: RepositoryProvider.of<FirebaseReviewRepository>(context),
            );
          },
        ),
      ],
      child: child,
    );
  }
}
