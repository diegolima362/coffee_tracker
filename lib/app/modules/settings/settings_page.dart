import 'package:coffee_tracker/app/shared/components/custom_switcher.dart';
import 'package:coffee_tracker/app/utils/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  final String title;

  const SettingsPage({Key key, this.title = "Settings"}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState
    extends ModularState<SettingsPage, SettingsController> {
  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Sair',
      content: 'Tem certeza que quer sair?',
      cancelActionText: 'Cancelar',
      defaultActionText: 'Sair',
    ).show(context);

    if (didRequestSignOut == true) {
      await controller.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(10),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Modo escuro'),
                trailing: Observer(
                  builder: (_) => CustomSwitch(
                    value: controller.dark,
                    onChanged: controller.setDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            title: Text(
              'Sair',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () => _confirmSignOut(context),
          ),
        ),
      ],
    );
  }
}
