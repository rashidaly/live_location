import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_location/provider/location_provider.dart';
import 'package:provider/provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        backgroundColor: Colors.amber,
      ),
      body: googleMapUi(),
    );
  }

  Widget googleMapUi() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationPosition != null) {
        return Column(
          children: [
            Expanded(
                child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: model.locationPosition!,
                zoom: 18,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(model.markers.values),
              onMapCreated: (GoogleMapController controller) {},
            ))
          ],
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
