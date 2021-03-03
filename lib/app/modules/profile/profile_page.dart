import 'package:coffee_tracker/app/shared/components/avatar.dart';
import 'package:coffee_tracker/app/shared/components/responsive.dart';
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
  Future<void> _confirmSignOut() async {
    final title = 'Sair';
    final content = 'Tem certeza que quer sair?';

    await Modular.to.showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Modular.navigator.pop(false),
            ),
            TextButton(
              child: Text('Sair'),
              onPressed: () async {
                Modular.navigator.pop(true);
                await controller.logout();
              },
            )
          ],
        );
      },
    );
  }

  bool _isLarge;

  @override
  Widget build(BuildContext context) {
    _isLarge = ResponsiveWidget.isLargeScreen(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildAvatar(),
              SizedBox(height: 20),
              Opacity(
                opacity: controller.user?.displayName != null ? 1.0 : 0.0,
                child: Text(
                  '${controller.user.displayName}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildContent()
            ],
          ),
        ),
      ),
    );
  }

  Observer _buildAvatar() {
    return Observer(
      builder: (_) {
        if (controller.savedImage != null) {
          return Avatar(
            image: Image.memory(controller.savedImage),
            radius: 75,
          );
        } else {
          final uri = controller.user?.photoURL;
          if ((uri?.isNotEmpty ?? false) && !uri.contains('/avatar.jpg')) {
            return Avatar(
              image: Image.network(uri),
              radius: 75,
            );
          } else {
            return Avatar(
              image: Image.asset('images/no-image.png'),
              radius: 75,
            );
          }
        }
      },
    );
  }

  Widget _buildContent() {
    final w = ResponsiveWidget.contentWidth(context);

    return Card(
      child: Container(
        width: w * (_isLarge ? .6 : 1),
        child: Column(
          children: [
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
              title: Text('Editar perfil'),
              onTap: controller.showEditPage,
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text('Sair'),
              onTap: _confirmSignOut,
            ),
          ],
        ),
      ),
    );
  }
}
