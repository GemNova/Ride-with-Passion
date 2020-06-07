import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:ride_with_passion/models/user.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/view_models/profile_view_model.dart';
import 'package:ride_with_passion/views/widgets/app_bar_blue_widget.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBarBlueWidget(),
        body: _buildProfileInformation(context, model),
      ),
    );
  }

  Widget _buildProfileInformation(
      BuildContext context, ProfileViewModel model) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          StreamBuilder(
              stream: model.userStream,
              builder: (context, AsyncSnapshot<User> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  User user = asyncSnapshot.data;
                  return _buildProfileImage(context, user);
                }
                return Container();
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildEditButton(model),
                _buildLogoutButton(model),
              ],
            ),
          ),
          mediumSpace,
          StreamBuilder(
              stream: model.userStream,
              builder: (context, AsyncSnapshot<User> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  User user = asyncSnapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: <Widget>[
                        _buildRowPairInformation('Vorname', user.firstName),
                        mediumSpace,
                        _buildRowPairInformation('Nachname', user.lastName),
                        mediumSpace,
                        _buildRowPairInformation('Geschlecht', user.gender),
                        mediumSpace,
                        _buildRowPairInformation('Biketyp', user.bikeType),
                        mediumSpace,
                        _buildRowPairInformation('Email', user.email),
                        mediumSpace,
                        _buildRowPairInformation(
                          'Geburstdatum',
                          user.birthDate == null
                              ? 'Kein Geburstdatum ausgewöhlt'
                              : DateFormat('MMM dd, yyyy')
                                  .format(user.birthDate),
                        ),
                        mediumSpace,
                        _buildAddressInformation(user),
                      ],
                    ),
                  );
                }
                return Container();
              }),
          bigSpace,
          Divider(),
          bigSpace,
          // Text("Meine Zeiten"),
          // ListView.separated(
          //     padding: EdgeInsets.only(right: 20),
          //     itemCount: model.rankList.length,
          //     shrinkWrap: true,
          //     separatorBuilder: (context, index) {
          //       return Divider();
          //     },
          //     itemBuilder: (context, index) {
          //       // if (model.filteredRankList.length != 1 &&
          //       //     (index == 0 || index == model.filteredRankList.length + 1)) {
          //       //   return Container(); // zero height: not visible
          //       // }
          //       final rank = model.rankList[index];
          //       return Column(
          //         children: <Widget>[
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               children: <Widget>[
          //                 Text(
          //                   '${index + 1}.',
          //                   style: title18cb,
          //                 ),
          //                 mediumSpace,
          //                 Expanded(
          //                   child: Text(
          //                     '${rank.userName} ${rank.lastName}',
          //                     style: medium18cb,
          //                   ),
          //                 ),
          //                 Text(
          //                   '${Duration(milliseconds: rank.trackedTime).toString().split('.')[0]}',
          //                   style: medium18sp.copyWith(
          //                       color: blackColor, fontSize: 16),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ],
          //       );
          //     }),
        ],
      ),
    );
  }

  Row _buildRowPairInformation(String label, String value) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(label.toUpperCase()),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildAddressInformation(User user) {
    String street = returnEmptyIfNull(user.street);
    String houseNumber = returnEmptyIfNull(user.houseNumber);
    String city = returnEmptyIfNull(user.city);
    String postCode = returnEmptyIfNull(user.postCode);
    String country = returnEmptyIfNull(user.country);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: Text('ADDRESSE')),
        Expanded(child: Text('$street $houseNumber $city $postCode $country'))
      ],
    );
  }

  Widget _buildEditButton(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: accentColor)),
            child: Text('BEARBEITEN'),
            onPressed: model.handleEditProfileButton,
          )
        ],
      ),
    );
  }

  Widget _buildLogoutButton(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: accentColor)),
            child: Text('LOGOUT'),
            onPressed: model.onLogoutPressed,
          )
        ],
      ),
    );
  }

  Stack _buildProfileImage(BuildContext context, User user) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: accentColor,
                offset: Offset(0, 1.0),
                spreadRadius: 0,
                blurRadius: 2,
              )
            ],
          ),
          height: 100,
          width: double.infinity,
        ),
        Positioned(
          top: 50,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: accentColor,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 49,
              backgroundImage: user.imageUrl == null
                  ? AssetImage(
                      "assets/app_icon.jpg",
                    )
                  : NetworkImage(user.imageUrl),
            ),
          ),
        ),
      ],
    );
  }

  String returnEmptyIfNull(String object) {
    if (object == null) {
      return '';
    } else {
      return '$object\n';
    }
  }
}
