import 'package:coffee_tracker/app/modules/restaurant/restaurant_controller.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantSearch extends SearchDelegate<RestaurantModel> {
  final RestaurantController controller;
  final List<RestaurantModel> _recent = List<RestaurantModel>();

  RestaurantModel selectedResult;
  List<RestaurantModel> suggestions = [];

  RestaurantSearch({@required this.controller});

  @override
  String get searchFieldLabel => 'Digite um nome ou cidade';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return controller.isDark ? ThemeData.dark() : ThemeData.light();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestions[index].name,
          ),
          onTap: () {
            controller.showDetails(restaurant: suggestions[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestions.clear();

    query.isEmpty
        ? suggestions = _recent
        : suggestions.addAll(
            controller.restaurants.where((e) =>
                e.name.toLowerCase().contains(query.toLowerCase()) ||
                e.city.toLowerCase().contains(query.toLowerCase())),
          );

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestions[index].name,
          ),
          onTap: () {
            selectedResult = suggestions[index];
            _recent.add(suggestions[index]);
            controller.showDetails(restaurant: suggestions[index]);
          },
        );
      },
    );
  }
}
