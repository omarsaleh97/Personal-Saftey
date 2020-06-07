import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/widgets/drawer.dart';

class NearestFacilities extends StatefulWidget {
  NearestFacilities({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _NearestFacilitiesState createState() => _NearestFacilitiesState();
}

class _NearestFacilitiesState extends State<NearestFacilities> {
  LocationData locationData;
  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      setState(() {
        locationData = locData;
      });
      print(locData.latitude);
      print(locData.longitude);
    } catch (error) {
      return;
    }
  }

  @override
  void initState() {
    _getCurrentUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        title: Text(
          "Nearby Facilities",
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(.1),
      ),
      body: locationData == null
          ? Center(
              child: CustomLoadingIndicator(
              customColor: primaryColor,
            ))
          : GoogleMap(
              // ignore: sdk_version_ui_as_code
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  locationData.latitude,
                  locationData.longitude,
                ),
                zoom: 16,
              ),

              markers: {
                Marker(
                  markerId: MarkerId('m1'),
                  position: LatLng(
                    locationData.latitude,
                    locationData.longitude,
                  ),
                ),
              },
              zoomGesturesEnabled: true,
              trafficEnabled: true,
              scrollGesturesEnabled: true,
              myLocationEnabled: true,
              indoorViewEnabled: true,
            ),
    );
  }
}
