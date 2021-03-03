import 'package:coffee_tracker/app/shared/components/customDetailsPage.dart';
import 'package:coffee_tracker/app/shared/components/responsive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  @override
  Widget build(BuildContext context) {
    final width = ResponsiveWidget.contentWidth(context);
    return ResponsivePage(
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
            Row(
              children: [
                Container(
                  child: _buildTextCity(),
                  width: width * .65,
                ),
                SizedBox(width: width * .01),
                Expanded(
                  child: _buildTextState(),
                ),
              ],
            ),
            _buildTextAddress(),
            _buildTextCommentary(),
            const SizedBox(height: 10),
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
          onPressed: controller.canSave ? controller.save : null,
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor,
            onPrimary: Theme.of(context).cardColor,
          ),
          child: Text('Salvar'),
        ),
      ),
    );
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

    super.initState();
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

  Widget _buildActionButtons() {
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
    final w = ResponsiveWidget.contentWidth(context);
    final h = MediaQuery.of(context).size.height * .4;

    return Observer(
      builder: (_) {
        if (controller.savedImage != null) {
          return Container(
            child: Image.memory(controller.savedImage),
            width: w,
            height: h,
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
    List<PlatformFile> _paths;

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation: " + e.toString());
    } catch (ex) {
      print(ex);
    }

    if (!mounted) return;

    if (_paths != null) {
      _paths.forEach((PlatformFile p) {
        controller.setImageFile(p.bytes);
        controller.setImagePath(p.path);
        controller.setImage(p.bytes);
      });
    }
  }
}
