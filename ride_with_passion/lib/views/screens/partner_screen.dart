import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/models/partner.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/partner_view_model.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:ride_with_passion/views/widgets/custom_loading_indicator.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PartnerViewModel>.withConsumer(
      viewModelBuilder: () => PartnerViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(),
        body: FutureBuilder<List<Partner>>(
            future: model.partners,
            initialData: [],
            builder:
                (BuildContext context, AsyncSnapshot<List<Partner>> snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final image = snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => FunctionUtils.launchURL(image.link),
                        child: CachedNetworkImage(
                          imageUrl: image.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation(accentColor),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomLoadingIndicator();
              }

              return Center(
                child: Text("Keine Partner gefunden"),
              );
            }),
      ),
    );
  }
}
