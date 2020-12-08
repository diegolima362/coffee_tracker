import 'package:coffee_tracker/app/shared/components/avatar.dart';
import 'package:coffee_tracker/app/shared/components/platform_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  const ProfilePage({Key key, this.title = "Perfil"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  Future<void> _confirmSignOut(BuildContext context) async {
    final title = 'Sair';
    final content = 'Tem certeza que quer sair?';

    final didRequestSignOut = kIsWeb
        ? await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          )
        : await PlatformAlertDialog(
            title: title,
            content: content,
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
        appBar: AppBar(title: Text(widget.title)),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildAvatar(),
                SizedBox(height: 10),
                Text(
                  controller.user.displayName,
                  style: TextStyle(fontSize: 18),
                ),
                FutureBuilder<void>(
                  future: controller.mediaStorage.loadCache(),
                  builder: (_, __) {
                    if (__.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Divider(height: 1.0),
                            ListTile(
                              title: Text('Deletar Cache'),
                              trailing: Text(
                                '${(controller.mediaStorage.storageUsage / 1024 / 1024).toStringAsFixed(2)} MB',
                              ),
                              onTap: () => controller.mediaStorage.flushCache(),
                            ),
                            Divider(height: 1.0),
                            ListTile(
                              title: Text('Tema Escuro'),
                              trailing: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  activeColor: Theme.of(context).accentColor,
                                  value: controller.dark,
                                  onChanged: controller.setDark,
                                ),
                              ),
                            ),
                            Divider(height: 1.0),
                            ListTile(
                              title: Text('Sair'),
                              onTap: () => _confirmSignOut(context),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Observer _buildAvatar() {
    return Observer(
      builder: (_) {
        if (controller.isOffline == null || !controller.isOffline)
          return Avatar(
            image: Image.asset('images/no-image.png'),
            radius: 75,
          );
        else
          return Avatar(
            image: Image.network(controller.user.photoURL),
            radius: 75,
          );
      },
    );
  }
}
