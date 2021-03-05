import 'package:coffee_tracker/app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_controller.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends ModularState<EditPage, ProfileController> {
  TextEditingController textControllerName;

  @override
  Widget build(BuildContext context) {
    final w = ResponsiveWidget.contentWidth(context);
    final _isLarge = ResponsiveWidget.isLargeScreen(context);

    return ResponsivePage(
      width: w * (_isLarge ? .6 : 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(),
            _buildActionButtons(),
            const SizedBox(height: 10),
            _buildTextName(),
            const SizedBox(height: 10),
            _buildSaveButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Container _buildSaveButton() {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: controller.updateProfile,
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          onPrimary: Theme.of(context).cardColor,
        ),
        child: Text('Salvar'),
      ),
    );
  }

  @override
  void dispose() {
    textControllerName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textControllerName = TextEditingController(text: controller.name);
    super.initState();
  }

  Widget _buildTextName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLength: 500,
      maxLines: null,
      controller: textControllerName,
      decoration: InputDecoration(
        labelText: 'Nome',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 20.0),
      onChanged: controller.setName,
    );
  }

  Widget _buildActionButtons() {
    return Observer(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.hasImage)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => controller.setImage(null),
            ),
          GestureDetector(
            onTap: _pickFile,
            child: IconButton(
              icon: Icon(controller.hasImage ? Icons.edit : Icons.add_a_photo),
              onPressed: _pickFile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Observer(
      builder: (_) {
        if (controller.savedImage != null) {
          return Avatar(
            image: Image.memory(controller.savedImage),
            radius: 75,
          );
        } else {
          return Container(
            width: 125,
            height: 125,
            child: Icon(
              Icons.camera_alt,
              size: 50,
              color: Colors.grey[800],
            ),
          );
        }
      },
    );
  }

  void _pickFile() async {
    final ImagePicker _picker = ImagePicker();

    try {
      final pickedFile =
          await (await _picker.getImage(source: ImageSource.gallery))
              .readAsBytes();

      controller.setImage(pickedFile);
    } catch (e) {
      print(e);
    }
  }
}
