import 'package:flutter/material.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Home screen"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: model.onLogoutPressed,
            child: Text("Log out"),
          ),
        ),
      ),
    );
  }
}
