import 'package:flutter/material.dart';

import 'responsive.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  bool _showBar = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).textTheme.caption.color;

    final isSmall = ResponsiveWidget.isSmallScreen(context);

    final w = ResponsiveWidget.contentWidth(context) * (isSmall ? .75 : .4);

    final border = OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(
        color: activeColor,
      ),
    );

    if (!isSmall || _showBar) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 30.0,
          width: w,
          child: TextField(
            textAlignVertical: TextAlignVertical.top,
            autofocus: isSmall,
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: activeColor,
              ),
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : GestureDetector(
                      child: Icon(
                        Icons.clear,
                        color: activeColor,
                      ),
                      onTap: () {
                        _controller.clear();
                        widget.onChanged('');
                      },
                    ),
              focusedBorder: border,
              disabledBorder: border,
              border: border,
              enabledBorder: border,
            ),
          ),
        ),
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.search,
          color: activeColor,
        ),
        tooltip: 'Pesquisar',
        onPressed: () {
          setState(() => _showBar = !_showBar);
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
