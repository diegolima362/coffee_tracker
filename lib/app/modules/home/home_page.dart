import 'package:coffee_tracker/app/modules/profile/profile_module.dart';
import 'package:coffee_tracker/app/modules/restaurant/restaurant_module.dart';
import 'package:coffee_tracker/app/modules/review/review_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_content/home_content_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Tab/Bottom-Bar with Modular and MobX"})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  List widgetOptions = [
    HomeContentPage(),
    RestaurantModule(),
    ReviewModule(),
    ProfileModule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return widgetOptions.elementAt(controller.currentIndex);
        },
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return Observer(builder: (_) {
      return BottomNavigationBar(
        showSelectedLabels: true,
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.currentIndex,
        onTap: (index) {
          controller.updateCurrentIndex(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Cafés'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet), label: 'Reviews'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      );
    });
  }
}
