import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/login_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: model.formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
            shrinkWrap: true,
            children: <Widget>[
              mediumSpace,
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 32, 50, 0),
                child: Image.asset("assets/ic_login.png"),
              ),
              mediumSpace,
              CustomTextField(
                label: "Email",
                hint: "Email",
                onSubmit: (_) =>
                    FocusScope.of(context).requestFocus(passwordFocusNode),
                onChanged: model.setEmail,
                validator: (email) =>
                    isEmail(email.trim()) ? null : "Keine gültige Email",
                keyboardType: TextInputType.emailAddress,
              ),
              smallSpace,
              CustomTextField(
                label: "Passwort",
                hint: "Passwort",
                obscure: true,
                focusNode: passwordFocusNode,
                onSubmit: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  model.onLoginPressed();
                },
                onChanged: model.setPassword,
                validator: (password) {
                  if (password.length < 6)
                    return 'Das Passwort muss mindestens 6 Buchstaben lang sein und mind 1 Zahl beinhalten!';
                  else
                    return null;
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              FlatButton(
                child: Text(
                  "Passwort vergessen?",
                  style: TextStyle(color: accentColor),
                ),
                onPressed: () => model.forgotPasswordPressed(),
              ),
              hugeSpace,
              model.isLoading
                  ? CustomLoadingIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: FlatButton(
                        color: accentColor,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.transparent)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          model.onLoginPressed();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "ANMELDEN",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
              mediumSpace,
              Center(
                child: Text(
                  "Neu hier?",
                  style: TextStyle(fontSize: 16, color: accentColor),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: model.onRegisterPressed,
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
    );
  }
}
