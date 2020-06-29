import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pit_sms_call_log/pit_sms_call_log.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../../widgets/sized_box_height_widget.dart';
import '../../../ui/home/home_navigator.dart';
import '../../../utils/device/device_utils.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;

import '../../facemask.dart';

List<SmsLog> smsList = [];
List<CallLog> callLogs = [];
List<String> callsnumbers = [];

/// Displays the navigation Home Cards
///
/// **Requires**
/// 1. [title] - For the title text
/// 2. [backgroundColor] - For the backgroundColor of the Card
/// 3. [imagePath] - For the Image to be displayed
/// 4. [backgroundImage] - Determines if the image is a background Image or not
/// 5. [route] - For the value to be used to navigate to the desired screen using [HomeNavigator]
class HomeCardWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String imagePath;
  final bool backgroundImage;
  final String route;
  //@override
  //void initState() {
  // super.initState();
  // initPlatformState();
  //}

  const HomeCardWidget({
    Key key,
    this.title,
    this.backgroundColor,
    this.imagePath,
    this.backgroundImage = false,
    this.route,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return GestureDetector(
      onTap: () => send(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBoxHeightWidget(screenHeight / 75),
          Container(
            height: screenHeight / 6,
            margin: const EdgeInsets.symmetric(
              horizontal: Dimens.horizontalPadding / 2,
            ),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  color: AppColors.boxShadowColor,
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: backgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth / 35),
              child: Center(
                child: Image.asset(imagePath),
              ),
            ),
          ),
          SizedBoxHeightWidget(screenHeight / 250),
        ],
      ),
    );
  }

  send(context) async {
    print("route hassan" + route);
    if (route == "/notify") {
      print("sucess");
      LocationResult result = await showLocationPicker(
        context,
        "AIzaSyD5tbckvyS6XOXEmW799WKvQLpTPgBnnvA",
        initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
        myLocationButtonEnabled: true,
        layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
      );
      print("result = $result");
      // setState((
      // ) =>
      //   print("hassan")
      _sendSMS();
      //   _pickedLocation = result

      //);
    } else if (route == "/mask") {
      print("success2");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Facemask()),
      );
    } else {
      HomeNavigator.navigatorKey.currentState.pushNamed(route);
    }
  }

  Future<void> initPlatformState() async {
    List<SmsLog> smsList = [];
    List<CallLog> callLogs = [];
    //  try {
    smsList = await PitSmsCallLog.getSmsLog(daysBefore: 30);
    callLogs = await PitSmsCallLog.getCallLog(daysBefore: 10);
    //}
    ///   if (!mounted) return;
    // setState(() {
    //   //this.smsList = smsList;
    //  // this.callLogs = callLogs;
    // });
    callLogs.forEach((call) {
      callsnumbers.add(call.callNumber);
    });
    print(callsnumbers.toString());
  }

  void _sendSMS() async {
    print(callsnumbers.toString());
    //var granted = await _requestPermission(PermissionGroup.contacts);

    PermissionsService().requestContactsPermission(onPermissionDenied: () {
      print('Permission has been denied');

      return;
    });

    String _result = await sendSMS(
            message:
                "This is a message to notify you that the user has been outside without wearing a mask so please maintain a distance of 6 feet from them",
            recipients: callsnumbers)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}

class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();
  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  /// Requests the users permission to read their location when the app is in use
  Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.locationWhenInUse);
  }

  Future<bool> requestPhonePermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.phone);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> requestPhonePermission1() async {
    return _requestPermission(PermissionGroup.contacts);
  }

  Future<bool> requestContactsPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.contacts);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }
}
