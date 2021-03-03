import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final Color color;
  final String label;
  final void Function() onTap;
  final bool active;
  final bool expanded;

  const CustomIconButton({
    Key key,
    @required this.icon,
    @required this.label,
    this.color,
    this.onTap,
    this.selectedIcon,
    this.active,
    this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).textTheme.bodyText1.color;
    final _disableColor = Theme.of(context).disabledColor;

    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment:
            expanded ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Icon(
            active ? selectedIcon ?? icon : icon,
            size: 38.0,
            color: active ? _color : _disableColor,
          ),
          if (expanded) ...[
            const SizedBox(width: 6.0),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  color: active ? _color : _disableColor,
                  fontWeight: active ? FontWeight.bold : FontWeight.w300,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
