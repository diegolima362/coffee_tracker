import 'package:coffee_tracker/app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/restaurant_info_card.dart';
import 'restaurant_controller.dart';
import 'sort_by.dart';

class RestaurantPage extends StatefulWidget {
  final String title;

  const RestaurantPage({Key key, this.title = "Cafés"}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState
    extends ModularState<RestaurantPage, RestaurantController> {
  bool _isSmall;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isSmall = ResponsiveWidget.isSmallScreen(context);

    return Scaffold(
      floatingActionButton: _isSmall ? _buildFAB() : null,
      body: Observer(
        builder: (_) => Column(
          children: [
            _buildActionBar(),
            Expanded(child: _buildContent(_)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final width = ResponsiveWidget.contentWidth(context);
    final portrait = ResponsiveWidget.isPortrait(context);

    double aspect;
    int count;
    double w;

    if (!_isSmall || !portrait) {
      count = 2;
      aspect = 5.0 / 2.0;
      w = width / 2.0;
    } else {
      count = 1;
      aspect = 3.0;
      w = width;
    }

    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (controller.restaurants.isEmpty) {
      return EmptyContent(
        title: 'Nada por aqui',
        message: 'Sem Restaurantes registrados!',
      );
    } else {
      final restaurants = controller.restaurants
          .where((r) => r
              .toString()
              .toLowerCase()
              .contains(controller.filter.toLowerCase()))
          .toList();

      final _length = restaurants.length + 1;

      return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          childAspectRatio: aspect,
        ),
        itemCount: _length,
        itemBuilder: (context, index) {
          if (_length == 1 && index == 0)
            return Center(child: Text('Sem resultados'));

          if (index == _length - 1) return SizedBox(height: 75.0);

          final restaurant = restaurants[index];
          return RestaurantInfoCard(
            restaurant: restaurant,
            mediaStorage: controller.mediaStorage,
            expanded: true,
            width: w,
            height: w * .6,
            onTap: () => controller.showDetails(restaurant),
          );
        },
      );
    }
  }

  Widget _buildActionBar() {
    return Card(
      child: Row(
        mainAxisAlignment: _isSmall
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.spaceEvenly,
        children: [
          if (!_isSmall) CustomAddButton(onTap: _addRestaurant),
          SearchBar(onChanged: controller.setFilter),
          OrderBy<SortBy>(
            onSelected: (value) => controller.sortBy(value),
            choices: ['A-Z', 'Nota', 'Data', 'Cidade', 'Visitas'],
            values: SortBy.values,
          ),
        ],
      ),
    );
  }

  Future<void> _addRestaurant() async {
    try {
      await controller.addRestaurant();
    } on PlatformException {
      final snackBar = SnackBar(
        content: Text(
          'Sem conexão com a internet',
          style: TextStyle(color: Theme.of(context).backgroundColor),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).accentColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      heroTag: 'add-restaurant',
      tooltip: 'Adicionar Restaurante',
      onPressed: _addRestaurant,
      child: Icon(Icons.add),
    );
  }
}
