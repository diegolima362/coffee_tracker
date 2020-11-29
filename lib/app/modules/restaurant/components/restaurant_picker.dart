import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantPicker extends StatefulWidget {
  final ValueChanged<RestaurantModel> selectRestaurant;
  final List<RestaurantModel> restaurant;
  final Color bgColor;
  final Color highlightColor;
  final double height;
  final double width;

  RestaurantPicker({
    Key key,
    this.selectRestaurant,
    this.restaurant,
    this.bgColor,
    this.highlightColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _RestaurantPickerState createState() => _RestaurantPickerState();
}

class _RestaurantPickerState extends State<RestaurantPicker> {
  List<RestaurantModel> _restaurants;
  int _selectedIndex = 0;

  @override
  void initState() {
    _restaurants = widget.restaurant;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    final h = widget.width ?? size.height;
    final bg = widget.bgColor ?? dark ? Colors.black : Colors.white;
    final textColor = Theme.of(context).accentColor;

    return GestureDetector(
      child: Container(
        height: h * 0.15,
        child: Row(
          children: [
            Text(
              'Local: ',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: Text(
                Format.capitalString(_restaurants[_selectedIndex].name),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              height: h * 0.15,
              child: CupertinoPicker(
                looping: false,
                backgroundColor: bg,
                onSelectedItemChanged: (index) => setState(() {
                  widget.selectRestaurant(_restaurants[index]);
                  _selectedIndex = index;
                }),
                itemExtent: h * .15,
                children: List<Widget>.generate(
                  _restaurants.length,
                  (int index) {
                    return Container(
                      child: Center(
                        child: Text(
                          Format.capitalString(_restaurants[index].name),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
