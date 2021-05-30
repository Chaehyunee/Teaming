import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: camel_case_types
class mapPage extends StatefulWidget {
  @override
  _mapPageState createState() => _mapPageState();
}

// ignore: camel_case_types
class _mapPageState extends State<mapPage> {
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId("GNU북카페"),
        draggable: false,
        position: LatLng(35.15547783347907, 128.1018879005094),
        infoWindow: InfoWindow(title: "GNU북카페")));
    _markers.add(Marker(
        markerId: MarkerId("투썸플레이스"),
        draggable: false,
        position: LatLng(35.151887270287084, 128.1052130085357),
        infoWindow: InfoWindow(title: "투썸플레이스")));
    _markers.add(Marker(
        markerId: MarkerId("커피품은도서관"),
        draggable: false,
        position: LatLng(35.1517305670474, 128.1058209625373),
        infoWindow: InfoWindow(title: "커피품은도서관")));
    _markers.add(Marker(
        markerId: MarkerId("반반스프링스"),
        draggable: false,
        position: LatLng(35.15380796815264, 128.10717955187877),
        infoWindow: InfoWindow(title: "반반스프링스")));
    _markers.add(Marker(
        markerId: MarkerId("커피비로터스"),
        draggable: false,
        position: LatLng(35.1534970591922, 128.10657378674202),
        infoWindow: InfoWindow(title: "커피비로터스")));
    _markers.add(Marker(
        markerId: MarkerId("공차"),
        draggable: false,
        position: LatLng(35.15426288399936, 128.10689947359742),
        infoWindow: InfoWindow(title: "공차")));
    _markers.add(Marker(
        markerId: MarkerId("더웨이닝커피"),
        draggable: false,
        position: LatLng(35.15622446252205, 128.10651227440417),
        infoWindow: InfoWindow(title: "더웨이닝커피")));
    _markers.add(Marker(
        markerId: MarkerId("The 달콤한 하루"),
        draggable: false,
        position: LatLng(35.158258791286926, 128.10687328584456),
        infoWindow: InfoWindow(title: "The 달콤한 하루")));
    _markers.add(Marker(
        markerId: MarkerId("TALE coffee"),
        draggable: false,
        position: LatLng(35.15966873305308, 128.10564515293743),
        infoWindow: InfoWindow(title: "TALE coffee")));
    _markers.add(Marker(
        markerId: MarkerId("이디야커피"),
        draggable: false,
        position: LatLng(35.160242783598875, 128.10624195651587),
        infoWindow: InfoWindow(title: "이디야커피")));
  }

  Future<Location> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    Location location = Location(
      lat: position.latitude,
      long: position.longitude,
    );

    return location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ],
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: getPosition(),
              builder: (context, AsyncSnapshot<Location> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GoogleMap(
                  markers: Set.from(_markers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data!.lat, snapshot.data!.long),
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                );
              })),
    );
  }
}

class Location {
  final double lat;
  final double long;

  Location({
    required this.lat,
    required this.long,
  });
}
