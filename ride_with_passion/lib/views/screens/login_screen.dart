import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/login_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Expanded(flex: 1, child: Image.asset("assets/ic_login.png")),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Form(
                    key: model.formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        CustomTextField(
                          label: "Email",
                          hint: "Email",
                          onSave: model.setEmail,
                          validator: (email) => isEmail(email.trim())
                              ? null
                              : "Keine gültige Email",
                        ),
                        smallSpace,
                        CustomTextField(
                          label: "Passwort",
                          hint: "Passwort",
                          onSave: model.setPassword,
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
                            : FlatButton(
                                color: accentColor,
                                shape: StadiumBorder(
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  model.onLoginPressed();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "ANMELDEN",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                        bigSpace,
                        Center(
                          child: Text(
                            "Neu hier?",
                            style: TextStyle(fontSize: 16, color: accentColor),
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => {},
                            child: Text("Registrieren",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: accentColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
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
}
