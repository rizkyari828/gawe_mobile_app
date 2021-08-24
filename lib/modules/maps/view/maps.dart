import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/view/editAkun/datadiri2akun.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:toast/toast.dart';


class MapsHome extends StatefulWidget {
  @override
  _MapsHomeState createState() => _MapsHomeState();
  final email;
  final globalid_employee;

  MapsHome({this.email, this.globalid_employee});
}

class _MapsHomeState extends State<MapsHome> {
  BaseEndPoint network = NetworkProvider();
  LatLng myLocation;
  Timer _timer;
  final Map<String, Marker> _marker = {};

  void getCurrentLocation() async{
//    _marker.clear();
    var currentLocation = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    setState(() {
      final myMarker = Marker(
          markerId: MarkerId("My Position"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(
              title: "My Location",
          )
      );
      _marker['Current Location'] = myMarker;
      myLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print("Lat :  ${currentLocation.latitude}");
    print("Lon : ${currentLocation.longitude}");
  }

  void periodicMethod() async{
    _timer = Timer.periodic(Duration(seconds: 2), (test) async{
      if(this.mounted){
        setState(() {
          getCurrentLocation();
          print("Get Location Ke ${test.tick}");
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    // getLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getCurrentLocation();
    // _timer.cancel();
    // periodicMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true, //biar teksnya di tengah
          title: Text(""),
          backgroundColor: mainColor,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: myLocation == null ? LatLng(-6.2973249,106.6956355) : myLocation,
                    zoom: 14.0
                ),
                markers: _marker.values.toSet(),
                gestureRecognizers:
                <Factory<OneSequenceGestureRecognizer>> [
                  Factory<OneSequenceGestureRecognizer>(
                        () => ScaleGestureRecognizer(),
                  )
                ].toSet(),
              ),

            ),

          ],
        ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left:30.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton.extended(

            onPressed: () {
              submit(myLocation.latitude, myLocation.longitude);
            },
            label: Text('Simpan'),
            icon: Icon(Icons.save_alt_rounded),
            backgroundColor: mainColor,
          ),
        ),
      ),
    );
  }

  void submit(lat, long) async {
    print(lat.toString());
    print(long.toString());
    print(widget.email.toString());
    ModelRegister data = await network.saveLocation(
        widget.email.toString(),
        lat.toString(),
        long.toString());

    if (data.status == 202 ) {
      Toast.show("Data berhasil disimpan", context,
          duration: 3, gravity: Toast.TOP);
      Navigator.of(context)
          .push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            AkunUser(id_employee: widget.globalid_employee,),
      ));
    }
  }
}