import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/reviews/model/review_model.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem({super.key, required this.item});
  final Review item;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //ui for circular image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Color.fromARGB(255, 186, 183, 183),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s",
                height: 10.w,
                width: 10.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: _theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < item.rating.floor()
                                    ? Icons.star
                                    : item.rating - index.toDouble() >= 1
                                        ? Icons.star
                                        : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                        ],
                      ),
                      Text(
                        'Day before',
                        style: _theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black54),
                      ),
                    ]),
                Gap(16),
                Text(
                  '${item.description}',
                  style: _theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
