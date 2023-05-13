import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('nothing here'),
          const SizedBox(height: 16),
          Text('Try another category',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
        ],
      ));
    } else {
      if (title != null) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title!),
          ),
          body: ListView.builder(
            itemCount: meals
                .length, //this line is important because otherwise flutter takes index range just from 0 to 1 and that will result in an error
            itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
            ),
          ),
        );
      } else {
        return Scaffold(
          body: ListView.builder(
            itemCount: meals
                .length, //this line is important because otherwise flutter takes index range just from 0 to 1 and that will result in an error
            itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
            ),
          ),
        );
      }
    }
  }
}
