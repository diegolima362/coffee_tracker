import 'package:coffee_tracker/app/shared/components/responsive.dart';
import 'package:flutter/material.dart';

import 'responsive.dart';

class OrderBy<T> extends StatelessWidget {
  final void Function(T value) onSelected;
  final List<String> choices;
  final List<T> values;

  const OrderBy({
    Key key,
    this.onSelected,
    this.choices,
    this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isSmall = ResponsiveWidget.isSmallScreen(context);
    final _color = Theme.of(context).textTheme.bodyText2.color;

    return PopupMenuButton<T>(
      tooltip: 'Ordenar',
      child: !_isSmall
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ordenar',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: _color,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.sort,
                color: _color,
              ),
            ),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return choices.map(
          (String choice) {
            return PopupMenuItem<T>(
              value: values[choices.indexOf(choice)],
              child: Text(choice),
            );
          },
        ).toList();
      },
    );
  }
}
