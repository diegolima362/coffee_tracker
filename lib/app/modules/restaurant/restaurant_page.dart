import 'package:coffee_tracker/app/modules/restaurant/components/restaurant_info_card.dart';
import 'package:coffee_tracker/app/modules/restaurant/sort_by.dart';
import 'package:coffee_tracker/app/shared/components/empty_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'restaurant_controller.dart';

class RestaurantPage extends StatefulWidget {
  final String title;

  const RestaurantPage({Key key, this.title = "Cafés"}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState
    extends ModularState<RestaurantPage, RestaurantController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: controller.searchDelegate,
              );
            },
          ),
          buildPopupMenuButton()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Adicionar Restaurante',
        onPressed: _addRestaurant,
      ),
      body: Observer(
        builder: _buildContent,
      ),
    );
  }

  Widget buildPopupMenuButton() {
    return PopupMenuButton<SortBy>(
      icon: Icon(Icons.sort_sharp),
      onSelected: (value) => controller.sortBy(value),
      itemBuilder: (BuildContext context) {
        final choices = ['A-Z', 'Nota', 'Data', 'Cidade', 'Visitas'];
        return choices.map((String choice) {
          return PopupMenuItem<SortBy>(
            value: SortBy.values[choices.indexOf(choice)],
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final portrait = height > width;
    final aspect = portrait ? width / (height / 6) : height / (width / 6);

    final _length = controller.restaurants.length;

    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (controller.restaurants.isEmpty) {
      return EmptyContent(
        title: 'Nada por aqui',
        message: 'Sem Restaurantes registrados!',
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: portrait ? 1 : 2,
          childAspectRatio: aspect,
        ),
        itemCount: _length,
        itemBuilder: (context, index) {
          final restaurant = controller.restaurants[index];
          return RestaurantInfoCard(
            restaurant: restaurant,
            mediaStorage: controller.mediaStorage,
            expanded: true,
            height: (portrait ? height : width) / 6,
            onTap: () => controller.showDetails(restaurant: restaurant),
          );
        },
      );
    }
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
}
