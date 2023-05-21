import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key,
      required this.category,
      required this.onSelectCategory}); // this is to understand which category that i will be displaying

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //gesture detector could have been added if just tap was the motive, inkwell while enbaling users to tap on widgets also show a response when tapped
      onTap: onSelectCategory,
      splashColor:
          Theme.of(context).primaryColor, // the color when it is tapped
      borderRadius: BorderRadius.circular(16),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity((0.9))
              ], begin: Alignment.topRight, end: Alignment.bottomRight)),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ) // child of container
          ),
    );
  }
}
