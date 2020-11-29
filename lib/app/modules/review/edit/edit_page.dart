import 'package:coffee_tracker/app/modules/restaurant/components/restaurant_picker.dart';
import 'package:coffee_tracker/app/shared/components/input_dropdown.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'edit_controller.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends ModularState<EditPage, EditController> {
  TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController(text: controller.text);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Observer(
            builder: (_) => FlatButton(
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).appBarTheme.iconTheme.color,
                ),
              ),
              onPressed: controller.restaurant != null
                  ? () => controller.save()
                  : null,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                _buildRate(),
                const SizedBox(height: 10.0),
                _buildText(),
                const SizedBox(height: 10.0),
                if (controller.review?.restaurantId == null)
                  Observer(builder: (_) => _buildRestaurant()),
                const SizedBox(height: 8.0),
                Observer(builder: (_) => _buildFinalDate()),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurant() {
    return controller.isLoading
        ? Text('Carregando')
        : Column(
            children: [
              RestaurantPicker(
                selectRestaurant: controller.setRestaurant,
                restaurant: controller.restaurants,
              ),
              Divider(),
            ],
          );
  }

  Widget _buildFinalDate() {
    final valueStyle = Theme.of(context).textTheme.headline6;

    return Row(
      children: [
        Expanded(
          child: InputDropdown(
            labelText: 'Data',
            valueText: Format.simpleDate(controller.visitDate),
            valueStyle: valueStyle,
            onPressed: _selectDate,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: InputDropdown(
            labelText: 'Horário',
            valueText: controller.visitTime.format(context),
            valueStyle: valueStyle,
            onPressed: _selectTime,
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      helpText: 'Data da visita',
    );

    if (pickedDate != null && pickedDate != controller.visitDate) {
      controller.setVisitDate(pickedDate);
    }
  }

  Future<void> _selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: controller.visitTime,
      helpText: 'Horário da visita',
    );

    if (pickedTime != null && pickedTime != controller.visitTime) {
      controller.setVisitTime(pickedTime);
    }
  }

  Widget _buildText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLines: null,
      controller: textController,
      decoration: InputDecoration(
        labelText: 'Comentários',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 20.0),
      onChanged: controller.setText,
    );
  }

  Widget _buildRate() {
    final iconSize = MediaQuery.of(context).size.aspectRatio > 1
        ? MediaQuery.of(context).size.height * 0.07
        : MediaQuery.of(context).size.width * 0.07;

    return Center(
      child: RatingBar.builder(
        initialRating: controller.review?.rate ?? 2.5,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        glow: false,
        itemSize: iconSize,
        itemBuilder: (_, __) {
          return Icon(Icons.star, color: Theme.of(context).primaryColor);
        },
        onRatingUpdate: controller.setRate,
      ),
    );
  }
}
