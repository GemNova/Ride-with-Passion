import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/login_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/view_models/register_view_model.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<RegisterViewModel>.withConsumer(
      viewModel: RegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(32.0),
          shrinkWrap: true,
          children: <Widget>[
            Image.asset(
              "assets/ic_login.png",
              height: 240,
            ),
            Form(
              key: model.formKey,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomTextField(
                          label: "Vorname",
                          hint: "Vorname",
                          onSubmit: (_) => FocusScope.of(context)
                              .requestFocus(lastNameFocusNode),
                          onChanged: model.setFirstName,
                          validator: (value) => value.isNotEmpty
                              ? null
                              : "Bitte gib einen Namen ein",
                        ),
                      ),
                      smallSpace,
                      Expanded(
                        child: CustomTextField(
                          label: "Nachname",
                          hint: "Nachname",
                          onSubmit: (_) => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                          focusNode: lastNameFocusNode,
                          onChanged: model.setLastName,
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    label: "Email",
                    hint: "Email",
                    focusNode: emailFocusNode,
                    onSubmit: (_) =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    onChanged: model.setEmail,
                    validator: (email) =>
                        isEmail(email.trim()) ? null : "Keine gültige Email",
                  ),
                  CustomTextField(
                    label: "Passwort",
                    hint: "Passwort",
                    obscure: true,
                    onChanged: model.setPassword,
                    focusNode: passwordFocusNode,
                    onSubmit: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      model.onRegisterPressed();
                    },
                    validator: (password) {
                      Pattern pattern =
                          r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(password))
                        return 'Das Passwort muss mindestens 6 Buchstaben lang sein und mind 1 Zahl beinhalten!';
                      else
                        return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  smallSpace,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                  bigSpace,
                  Center(
                    child: InkWell(
                      onTap: model.onLoginPressed,
                      child: Text("Zum Login",
                          style: TextStyle(
                              fontSize: 18,
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
