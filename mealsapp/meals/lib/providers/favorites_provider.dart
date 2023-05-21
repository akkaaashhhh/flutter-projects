import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier()
      : super(
            []); //super calls the parent class which here is statenotifier class, to which we are passing an empty list

  bool toggleMealFavoriteStatis(Meal meal) {
    bool isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; // the state object is used to address the datastructure passed on to the super class via the constructor
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
}); // statenotifierprovider is required in order to provide data that changes dynamically through the use of a riverpod provider
