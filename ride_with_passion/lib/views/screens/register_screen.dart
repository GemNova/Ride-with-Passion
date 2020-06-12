import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';
import 'package:ride_with_passion/views/widgets/agree_terms_widget.dart';
import 'package:ride_with_passion/views/widgets/agree_terms_widget2.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';
import 'package:ride_with_passion/views/widgets/date_field_widget.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode typeFocusNode = FocusNode();
  final FocusNode streetFocusNode = FocusNode();
  final FocusNode houseNumberFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode postCodeFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<RegisterViewModel>.withConsumer(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 10),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Image.asset(
                  "assets/ic_login.png",
                ),
              ),
              Expanded(
                flex: 9,
                child: Form(
                  key: model.formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          label: "Vorname",
                          hint: "Vorname",
                          onSubmit: (_) => FocusScope.of(context)
                              .requestFocus(lastNameFocusNode),
                          onChanged: model.setFirstName,
                          validator: (value) => value.isNotEmpty
                              ? null
                              : "Bitte gib einen Namen ein",
                        ),
                        CustomTextField(
                          label: "Nachname",
                          hint: "Nachname",
                          onSubmit: (_) => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                          focusNode: lastNameFocusNode,
                          onChanged: model.setLastName,
                        ),
                        CustomTextField(
                          label: "Email",
                          hint: "Email",
                          focusNode: emailFocusNode,
                          onSubmit: (_) => FocusScope.of(context)
                              .requestFocus(passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: model.setEmail,
                          validator: (email) => isEmail(email.trim())
                              ? null
                              : "Keine gültige Email",
                        ),
                        CustomTextField(
                          label: "Passwort",
                          hint: "Passwort",
                          obscure: true,
                          onChanged: model.setPassword,
                          focusNode: passwordFocusNode,
                          onSubmit: (_) => FocusScope.of(context)
                              .requestFocus(typeFocusNode),
                          validator: (password) {
                            if (password.length < 6) {
                              return 'Das Passwort muss mindestens 6 Zeichen lang sein und mind 1 Zahl beinhalten!';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        smallSpace,
                        _buildTypeDropDown(model, context),
                        smallSpace,
                        _buildGenderDropDown(model, context),
                        smallSpace,
                        DateFieldWidget(
                            label: 'Geburstdatum (optional)',
                            text: 'Bitte wähle dein Geburtsdatum (optional)',
                            onChanged: model.setBirthday,
                            date: model.birthDate,
                            iconData: Icons.card_giftcard),
                        smallSpace,
                        _buildAddressGroup(model, context),
                        mediumSpace,
                        _buildImageContainer(model, context),
                        _buildImagePicker(model, context),
                        bigSpace,
                        AgreeTermsWidget(),
                        mediumSpace,
                        AgreeTermsWidget2(),
                        bigSpace,
                        model.isLoading
                            ? CustomLoadingIndicator()
                            : RaisedButton(
                                color: accentColor,
                                shape: StadiumBorder(
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                onPressed: model.isButtonEnabled
                                    ? () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        model.onRegisterPressed();
                                      }
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Registrieren",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                        bigSpace,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTypeDropDown(RegisterViewModel model, BuildContext context) {
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

  _buildGenderDropDown(RegisterViewModel model, BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        isExpanded: true,
        hint: Text(
          'Geschlecht (optional)',
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

  _buildImageContainer(RegisterViewModel model, BuildContext context) {
    return model.image == null
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
              backgroundImage: FileImage(
                (model.image),
              ),
            ),
          );
  }

  _buildImagePicker(RegisterViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: CupertinoButton(
        padding: EdgeInsets.all(4),
        color: accentColor,
        disabledColor: disabledColor,
        child: Text(
          model.image == null
              ? 'Wähle dein Bild aus (optional)'
              : 'Ändere Bild',
          style: medium20sp,
          textAlign: TextAlign.center,
        ),
        onPressed: () => loadAssets(model),
      ),
    );
  }

  Widget _buildAddressGroup(RegisterViewModel model, BuildContext context) {
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
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(cityFocusNode),
                  focusNode: houseNumberFocusNode,
                  onChanged: model.setHouseNumber,
                ),
                CustomTextField(
                  label: "Stadt",
                  hint: "Stadt",
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(postCodeFocusNode),
                  focusNode: cityFocusNode,
                  onChanged: model.setCity,
                ),
                CustomTextField(
                  label: "Postleitzahl",
                  hint: "Postleitzahl",
                  onSubmit: (_) =>
                      FocusScope.of(context).requestFocus(countryFocusNode),
                  focusNode: postCodeFocusNode,
                  onChanged: model.setPostCode,
                ),
                CustomTextField(
                  label: "Land",
                  hint: "Land",
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

  Future<void> loadAssets(RegisterViewModel model) async {
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
