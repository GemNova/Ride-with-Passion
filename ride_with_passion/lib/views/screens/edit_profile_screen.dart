import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/edit_profile_view_model.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';
import 'package:ride_with_passion/views/widgets/date_field_widget.dart';

class EditProfileScreen extends StatelessWidget {
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode typeFocusNode = FocusNode();
  final FocusNode streetFocusNode = FocusNode();
  final FocusNode houseNumberFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode postCodeFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<EditProfileViewModel>.withConsumer(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(
          firstText: 'PROFIL',
          secondText: 'BEARBEITEN',
        ),
        body: Form(
          key: model.formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    label: "Vorname",
                    hint: "Vorname",
                    textEditingController: model.textEditingControllerFirstName,
                    onSubmit: (_) =>
                        FocusScope.of(context).requestFocus(lastNameFocusNode),
                    onChanged: model.setFirstName,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Bitte gib einen Namen ein",
                  ),
                  CustomTextField(
                    label: "Nachname",
                    hint: "Nachname",
                    textEditingController: model.textEditingControllerLastName,
                    onSubmit: (_) =>
                        FocusScope.of(context).requestFocus(typeFocusNode),
                    focusNode: lastNameFocusNode,
                    onChanged: model.setLastName,
                  ),
                  smallSpace,
                  _buildTypeDropDown(model, context),
                  smallSpace,
                  _buildGenderDropDown(model, context),
                  smallSpace,
                  DateFieldWidget(
                      label: 'Geburstdatum (optional)',
                      text: 'Bitte wähle dein Geburtsdatum',
                      onChanged: model.setBirthday,
                      date: model.birthDate,
                      iconData: Icons.card_giftcard),
                  smallSpace,
                  _buildAddressGroup(model, context),
                  mediumSpace,
                  _buildImageContainer(model, context),
                  _buildImagePicker(model, context),
                  bigSpace,
                  model.isLoading
                      ? CustomLoadingIndicator()
                      : RaisedButton(
                          color: accentColor,
                          shape: StadiumBorder(
                              side: BorderSide(color: Colors.transparent)),
                          onPressed: model.isButtonEnabled()
                              ? () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  model.onEditPressed();
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Profil bearbeiten",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                  bigSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTypeDropDown(EditProfileViewModel model, BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        isExpanded: true,
        hint: Text(
          'Rad-Typ auswählen',
          style: TextStyle(color: Colors.grey[500]),
        ),
        value: model.type,
        onChanged: model.setType,
        iconEnabledColor: accentColor,
        items: model.types.map((String type) {
          return DropdownMenuItem(
            value: type,
            child: Text(
              type,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildGenderDropDown(EditProfileViewModel model, BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        isExpanded: true,
        hint: Text(
          'Geschlecht',
          style: TextStyle(color: Colors.grey[500]),
        ),
        value: model.gender,
        onChanged: model.setGender,
        iconEnabledColor: accentColor,
        items: model.genders.map((String type) {
          return DropdownMenuItem(
            value: type,
            child: Text(
              type,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildImageContainer(EditProfileViewModel model, BuildContext context) {
    return model.image == null && model.imageUrl == null
        ? Center(
            child: Icon(
              Icons.person_add,
              size: 100,
              color: disabledColor,
            ),
          )
        : Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: model.imageUrl != null
                  ? CachedNetworkImageProvider(model.imageUrl)
                  : FileImage((model.image)),
            ),
          );
  }

  _buildImagePicker(EditProfileViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: CupertinoButton(
        padding: EdgeInsets.all(4),
        color: accentColor,
        disabledColor: disabledColor,
        child: Text(
          model.image != null || model.imageUrl != null
              ? 'Ändere Bild'
              : 'Wähle dein Bild aus',
          style: medium20sp,
          textAlign: TextAlign.center,
        ),
        onPressed: () => loadAssets(model),
      ),
    );
  }

  Widget _buildAddressGroup(EditProfileViewModel model, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Addresse (optional)',
            style: title18cb,
          ),
          smallSpace,
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                CustomTextField(
                  textEditingController: model.textEditingControllerStreet,
                  label: "Straße",
                  hint: "Straße",
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(houseNumberFocusNode),
                  focusNode: streetFocusNode,
                  onChanged: model.setStreet,
                ),
                CustomTextField(
                  label: "Hausnummer",
                  hint: "Hausnummer",
                  textEditingController: model.textEditingControllerHouseNumber,
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(cityFocusNode),
                  focusNode: houseNumberFocusNode,
                  onChanged: model.setHouseNumber,
                ),
                CustomTextField(
                  label: "Stadt",
                  hint: "Stadt",
                  textEditingController: model.textEditingControllerCity,
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(postCodeFocusNode),
                  focusNode: cityFocusNode,
                  onChanged: model.setCity,
                ),
                CustomTextField(
                  label: "Postleitzahl",
                  hint: "Postleitzahl",
                  textEditingController: model.textEditingControllerPostCode,
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(countryFocusNode),
                  focusNode: postCodeFocusNode,
                  onChanged: model.setPostCode,
                ),
                CustomTextField(
                  label: "Land",
                  hint: "Land",
                  textEditingController: model.textEditingControllerCountry,
                  focusNode: countryFocusNode,
                  onChanged: model.setCountry,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadAssets(EditProfileViewModel model) async {
    await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((image) async {
      if (image == null) return;
      final croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: accentColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            aspectRatioPickerButtonHidden: true,
            aspectRatioLockEnabled: true,
            minimumAspectRatio: 1.0,
          ));

      model.setImage(croppedFile);
    });
  }
}
