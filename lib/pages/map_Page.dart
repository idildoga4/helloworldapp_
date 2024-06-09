import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helloworld/bottomnavbar.dart';


class MapPage extends StatefulWidget{
  const MapPage({super.key});
  @override 
  State<MapPage>createState()=>_mapPageState();
}

class _mapPageState extends State<MapPage>
{
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.02863, 28.97440);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: {
            const Marker(markerId: const MarkerId("İstanbul Hava Kuvvetleri Müzesi"),
            position: LatLng(40.96572220407477, 28.82589878504676),
            infoWindow: InfoWindow(title: "İstanbul Hava Kuvvetleri Müzesi"),
            ),
            const Marker(markerId: const MarkerId("Yerebatan Sarnıcı"),
            position: LatLng(41.00906407096317, 28.97772779591741),
            infoWindow: InfoWindow(title: "Yerebatan Sarnıcı")),
            const Marker(markerId: const MarkerId("Sultanahmet Camii"),
            position: LatLng(41.0056960315911, 28.97639742004292),
            infoWindow: InfoWindow(title: "Sultanahmet Camii")),
            const Marker(markerId: const MarkerId("Bakırköy Merkez Kalesi"),
            position: LatLng(40.95903742127042, 28.8302091875009),
            infoWindow: InfoWindow(title: "Bakırköy Merkez Kalesi")),
            const Marker(markerId: const MarkerId("Sivayuşpaşa Köşkü"),
            position: LatLng(41.0039683319368, 28.85273305178486),
            infoWindow: InfoWindow(title: "Sivayuşpaşa Köşkü")),
          }
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 2,),
      ),
      
    );
  }
}