import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_map_location_picker_example/pages/facemask.dart';
import 'package:google_map_location_picker_example/pages/gotoquiz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pit_sms_call_log/pit_sms_call_log.dart';

import 'generated/i18n.dart';
import 'package:permission_handler/permission_handler.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
 
  LocationResult _pickedLocation;
  
  List<SmsLog> smsList = [] ;
  List<CallLog> callLogs = [];
  List<String> callsnumbers = [];
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }


  @override
  Widget build(BuildContext context) {

 
    return MaterialApp(
//      theme: ThemeData.dark(),
      title: 'location picker',
      localizationsDelegates: const [
        location_picker.S.delegate,
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ar', ''),
        Locale('pt', ''),
        Locale('tr', ''),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('location picker'),
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    LocationResult result = await showLocationPicker(
                      context,
                      "AIzaSyAdynPwusxRGr6CjrUaNhpns5MFWZ3a7qM",
                      initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                      myLocationButtonEnabled: true,
                      layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
                    );
                    print("result = $result");
                    setState((
                    ) =>
                 //   print("hassan")
                    _sendSMS()
                  //   _pickedLocation = result
                     
                     
                     );
                  },
                  child: Text('Pick location'),
                ),
                RaisedButton(
                  onPressed: () async {
               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Facemask()),
  );   
              //       setState((
              //       ) =>
              //    //   print("hassan")
              // //      _sendSMS()
              //     //   _pickedLocation = result
                     
                     
              //        );
                  },
                  child: Text('Face mask detection'),
                ),
                RaisedButton(
                  onPressed: () async {
               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Gotoquiz()),
  );   
              //       setState((
              //       ) =>
              //    //   print("hassan")
              // //      _sendSMS()
              //     //   _pickedLocation = result
                     
                     
              //        );
                  },
                  child: Text('Go to quiz page'),
                ),
                Text(_pickedLocation.toString()),
              ],
            ),
          );
        }),
      ),
    );
  }
  Future<void> initPlatformState() async {

    List<SmsLog> smsList = [] ;
    List<CallLog> callLogs = [];
  //  try {
      smsList = await PitSmsCallLog.getSmsLog(daysBefore: 30);
      callLogs = await PitSmsCallLog.getCallLog(daysBefore: 10);
    //} 
    if (!mounted) return;
    setState(() {
      this.smsList = smsList;
      this.callLogs = callLogs;
    });
    callLogs.forEach((call){
     callsnumbers.add(call.callNumber);
         });
  print(callsnumbers.toString());
  }
  void _sendSMS() async {
 print(callsnumbers.toString());
  //var granted = await _requestPermission(PermissionGroup.contacts);
 
 PermissionsService().requestContactsPermission(
                  onPermissionDenied: () {
                print('Permission has been denied');
              
              return;
              }
              
              );

 String _result = await sendSMS(message:"Thi user want to notify you that he was outside in public in this panademic so please five feets apart from him when you meet him ", recipients: callsnumbers)
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
  