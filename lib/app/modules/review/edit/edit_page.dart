import 'package:coffee_tracker/app/shared/components/components.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:select_dialog/select_dialog.dart';

import 'edit_controller.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends ModularState<EditPage, EditController> {
  TextEditingController textController;
  TextEditingController rateController;

  @override
  void initState() {
    textController = TextEditingController(text: controller.text);
    rateController = TextEditingController(text: controller.rate.toString());
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Observer(builder: (_) => _buildRate()),
            const SizedBox(height: 10.0),
            if (controller.review?.restaurantId == null)
              Observer(builder: (_) => _buildRestaurant()),
            const SizedBox(height: 8.0),
            Observer(builder: (_) => _buildFinalDate()),
            const SizedBox(height: 10.0),
            _buildText(),
            const SizedBox(height: 20.0),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Container _buildSaveButton() {
    return Container(
      height: 50,
      child: Observer(
        builder: (_) => ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor,
            onPrimary: Theme.of(context).cardColor,
          ),
          onPressed: controller.canSave ? controller.save : null,
          child: Text('Salvar'),
        ),
      ),
    );
  }

  Widget _buildRestaurant() {
    return InputDropdown(
      onPressed: _pickRestaurant,
      labelText: 'Lugar',
      valueStyle: Theme.of(context).textTheme.headline6,
      valueText: controller.restaurant?.name ?? 'Carregando',
    );
  }

  void _pickRestaurant() {
    SelectDialog.showModal<RestaurantModel>(
      context,
      label: 'Escolher lugar',
      searchHint: 'Digite o nome',
      selectedValue: controller.restaurant,
      items: controller.restaurants,
      onChange: controller.setRestaurant,
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
      initialEntryMode: TimePickerEntryMode.input,
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
    return Center(
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: controller.rate ?? 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            maxRating: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            glow: false,
            itemBuilder: (_, __) {
              return Icon(Icons.star);
            },
            onRatingUpdate: (r) {
              controller.setRate(r);
              rateController.text = r.toStringAsFixed(1);
            },
          ),
          Container(
            width: 50,
            child: TextFormField(
              maxLength: 3,
              textAlign: TextAlign.center,
              controller: rateController,
              onChanged: (s) => controller.setRate(
                (double.tryParse(s.replaceAll(',', '.')) ?? 0),
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(counterText: ''),
            ),
          ),
        ],
      ),
    );
  }
}
