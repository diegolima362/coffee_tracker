import 'package:coffee_tracker/app/shared/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResponsivePage extends StatelessWidget {
  final Widget body;
  final double width;

  const ResponsivePage({Key key, this.body, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = width ?? ResponsiveWidget.contentWidth(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Center(
          heightFactor: 1,
          child: Card(
            child: Container(
              width: w,
              child: SingleChildScrollView(
                child: body,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final padding = ResponsiveWidget.appBarPadding(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(left: padding),
        child: GestureDetector(
          onTap: () => Modular.to.popUntil(
            ModalRoute.withName('/home'),
          ),
          child: Text(
            'Coffee Tracker',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: padding),
          child: TextButton(
            child: Text(
              'Voltar',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () => Modular.to.pop(),
          ),
        ),
      ],
    );
  }
}
