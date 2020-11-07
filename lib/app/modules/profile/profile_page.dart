import 'package:coffee_tracker/app/modules/settings/settings_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  const ProfilePage({Key key, this.title = "Profile"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  List widgetOptions = [
    Container(color: Colors.amber),
    Container(color: Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(child: Text('Seus Dados')),
                Tab(child: Text('Configurações')),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('Dados'),
                ),
              ),
              Container(
                child: SettingsModule(),
              ),
            ],
          )),
    );
  }
}
