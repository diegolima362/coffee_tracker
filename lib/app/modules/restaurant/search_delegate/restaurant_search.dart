import 'package:coffee_tracker/app/modules/restaurant/restaurant_controller.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:diacritic/diacritic.dart';
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
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryIconTheme: theme.iconTheme,
        primaryColor: theme.appBarTheme.color,
        textTheme: TextTheme());
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
    if (suggestions.isEmpty)
      return EmptyContent(
        title: 'Nada por aqui!',
        message: 'Nenhum resultado encontrado',
      );

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            Format.capitalString(suggestions[index].name),
          ),
          subtitle: Text(Format.capitalString(suggestions[index].city)),
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
                removeDiacritics(e.name.toLowerCase())
                    .contains(removeDiacritics(query.toLowerCase())) ||
                removeDiacritics(removeDiacritics(e.city.toLowerCase()))
                    .contains(removeDiacritics(query.toLowerCase()))),
          );

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            Format.capitalString(suggestions[index].name),
          ),
          subtitle: Text(Format.capitalString(suggestions[index].city)),
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
