import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';
import 'package:ride_with_passion/views/widgets/agree_terms_widget.dart';
import 'package:ride_with_passion/views/widgets/agree_terms_widget2.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode typeFocusNode = FocusNode();

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
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
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
                        onSubmit: (_) =>
                            FocusScope.of(context).requestFocus(emailFocusNode),
                        focusNode: lastNameFocusNode,
                        onChanged: model.setLastName,
                      ),
                      CustomTextField(
                        label: "Email",
                        hint: "Email",
                        focusNode: emailFocusNode,
                        onSubmit: (_) => FocusScope.of(context)
                            .requestFocus(passwordFocusNode),
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
                        onSubmit: (_) =>
                            FocusScope.of(context).requestFocus(typeFocusNode),
                        validator: (password) {
                          if (password.length < 6)
                            return 'Das Passwort muss mindestens 6 Buchstaben lang sein';
                          else
                            return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      smallSpace,
                      _buildTypeDropDown(model, context),
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
                                  side: BorderSide(color: Colors.transparent)),
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
        focusNode: typeFocusNode,
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
}
