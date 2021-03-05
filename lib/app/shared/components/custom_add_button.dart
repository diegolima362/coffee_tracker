import 'package:flutter/material.dart';

import 'responsive.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    Key key,
    this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final _isSmall = ResponsiveWidget.isSmallScreen(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            color: Theme.of(context).textTheme.bodyText2.color,
            size: 12,
          ),
          if (!_isSmall)
            Text(
              'Adicionar',
              style: Theme.of(context).textTheme.bodyText2,
            ),
        ],
      ),
    );
  }
}
