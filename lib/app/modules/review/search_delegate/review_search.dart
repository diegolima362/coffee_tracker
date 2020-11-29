import 'package:coffee_tracker/app/modules/review/review_controller.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

class ReviewSearch extends SearchDelegate<ReviewModel> {
  final ReviewController controller;
  final List<ReviewModel> _recent = List<ReviewModel>();

  ReviewModel selectedResult;
  List<ReviewModel> suggestions = [];

  ReviewSearch({@required this.controller});

  @override
  String get searchFieldLabel => 'Digite um restaurante ou data';

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
          title: Text(Format.capitalString(suggestions[index].restaurantName)),
          subtitle: Text(Format.date(suggestions[index].visitDate)),
          onTap: () {
            controller.showDetails(review: suggestions[index]);
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
        : suggestions.addAll(controller.reviews.where((e) =>
            removeDiacritics(e.restaurantName.toLowerCase())
                .contains(removeDiacritics(query.toLowerCase())) ||
            Format.fullDate(e.visitDate)
                .toLowerCase()
                .contains(query.toLowerCase())));

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(Format.capitalString(suggestions[index].restaurantName)),
          subtitle: Text(Format.date(suggestions[index].visitDate)),
          onTap: () {
            selectedResult = suggestions[index];
            _recent.add(suggestions[index]);
            controller.showDetails(review: suggestions[index]);
          },
        );
      },
    );
  }
}
