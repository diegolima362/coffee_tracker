import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_controller.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends ModularState<EditPage, EditController> {
  TextEditingController textControllerName;
  TextEditingController textControllerCity;
  TextEditingController textControllerState;
  TextEditingController textControllerAddress;
  TextEditingController textControllerCommentary;

  FocusNode nameFocus;
  FocusNode cityFocus;
  FocusNode stateFocus;
  FocusNode addressFocus;
  FocusNode commentaryFocus;

  ImagePicker picker;

  @override
  void initState() {
    textControllerName = TextEditingController(text: controller.name);
    textControllerCity = TextEditingController(text: controller.city);
    textControllerState = TextEditingController(text: controller.state);
    textControllerAddress = TextEditingController(text: controller.address);
    textControllerCommentary =
        TextEditingController(text: controller.commentary);

    nameFocus = FocusNode();
    cityFocus = FocusNode();
    stateFocus = FocusNode();
    addressFocus = FocusNode();
    commentaryFocus = FocusNode();

    picker = ImagePicker();

    super.initState();
  }

  @override
  void dispose() {
    textControllerName.dispose();
    textControllerCity.dispose();
    textControllerState.dispose();
    textControllerAddress.dispose();
    textControllerCommentary.dispose();

    nameFocus.dispose();
    cityFocus.dispose();
    stateFocus.dispose();
    addressFocus.dispose();
    commentaryFocus.dispose();

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
              onPressed: controller.canSave ? controller.save : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                _image(),
                _buttons(),
                const SizedBox(height: 10),
                _buildTextName(),
                Row(
                  children: [
                    Container(
                      child: _buildTextCity(),
                      width: MediaQuery.of(context).size.width * .65,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .01),
                    Expanded(
                      child: _buildTextState(),
                    ),
                  ],
                ),
                _buildTextAddress(),
                _buildTextCommentary(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
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
      focusNode: nameFocus,
      onEditingComplete: () {
        final newFocus = controller.name.isNotEmpty ? cityFocus : nameFocus;
        FocusScope.of(context).requestFocus(newFocus);
      },
    );
  }

  Widget _buildTextCity() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLength: 500,
      maxLines: null,
      controller: textControllerCity,
      decoration: InputDecoration(
        labelText: 'Cidade',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 20.0),
      onChanged: controller.setCity,
      focusNode: cityFocus,
      onEditingComplete: () {
        final newFocus = controller.city.isNotEmpty ? stateFocus : cityFocus;
        FocusScope.of(context).requestFocus(newFocus);
      },
    );
  }

  Widget _buildTextState() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLength: 2,
      maxLines: null,
      controller: textControllerState,
      decoration: InputDecoration(
        labelText: 'Estado',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 20.0),
      onChanged: controller.setState,
      focusNode: stateFocus,
      onEditingComplete: () {
        final newFocus =
            controller.state.isNotEmpty ? addressFocus : stateFocus;
        FocusScope.of(context).requestFocus(newFocus);
      },
    );
  }

  Widget _buildTextAddress() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLength: 500,
      maxLines: null,
      controller: textControllerAddress,
      decoration: InputDecoration(
        labelText: 'Endereço',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 20.0),
      onChanged: controller.setAddress,
      focusNode: addressFocus,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(commentaryFocus),
    );
  }

  Widget _buildTextCommentary() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: null,
      controller: textControllerCommentary,
      decoration: InputDecoration(
        labelText: 'Comentários',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 20.0),
      onChanged: controller.setCommentary,
      focusNode: commentaryFocus,
      onEditingComplete: () {
        if (controller.canSave) controller.save();
      },
    );
  }

  Widget _image() {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height * .4;

    return Observer(
      builder: (_) {
        if (controller.hasImage) {
          return Container(
            child: controller.savedImage,
            width: w,
            height: h,
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(100)),
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

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      controller.setImageFile(File(pickedFile.path));
    } else {
      print('> no image selected.');
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Galeria'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Câmera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 2000,
      maxWidth: 2000,
    );

    if (pickedFile != null) {
      controller.setImageFile(File(pickedFile.path));
    } else {
      print('> no image selected.');
    }
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 600,
      maxWidth: 600,
    );

    if (pickedFile != null) {
      controller.setImageFile(File(pickedFile.path));
    } else {
      print('> no image selected.');
    }
  }

  Widget _buttons() {
    return Observer(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.hasImage)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => controller.setImageFile(null),
            ),
          GestureDetector(
            onTap: () => _showPicker(context),
            child: IconButton(
              icon: Icon(controller.hasImage ? Icons.edit : Icons.add_a_photo),
              onPressed: () => _showPicker(context),
            ),
          ),
        ],
      ),
    );
  }
}
