import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMapScreen extends StatefulWidget {
  ServiceMapScreen({Key key}) : super(key: key);

  @override
  _ServiceMapScreenState createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng latlng = LatLng(
    13.842797, 100.5772309,
  );
 

  @override
  void initState() { 
    super.initState();
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('baac-01'):Marker(
      markerId: MarkerId('baac-01'),
      position: LatLng(13.842797, 100.5772309),
      infoWindow: InfoWindow(title: 'ธกส สำนักงานใหญ่', snippet: 'แขวง เสนานิคม เขตจตุจักร กรุงเทพมหานคร 10220'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },  
    ),
    MarkerId('baac-02'):Marker(
      markerId: MarkerId('baac-02'),
      position: LatLng(13.841135, 100.545355),
      infoWindow: InfoWindow(
        title: 'ธนาคาร ธกส. สาขาย่อยประชาชื่น', 
        snippet: '14 ถนน เทศบาลสงเคราะห์ แขวง ลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },  
    ),
    MarkerId('baac-03'):Marker(
      markerId: MarkerId('baac-03'),
      position: LatLng(13.821531, 100.591431),
      infoWindow: InfoWindow(
        title: 'ธนาคารธกส. วังหิน', 
        snippet: 'ซอย ลาดพร้าววังหิน 52 แขวง ลาดพร้าว เขตลาดพร้าว กรุงเทพมหานคร 10230'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },  
    ),
    MarkerId('baac-04'):Marker(
      markerId: MarkerId('baac-04'),
      position: LatLng(13.821220, 100.591206),
      infoWindow: InfoWindow(
        title: 'ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร สาขาย่อยโชคชัย 4', 
        snippet: '481 ถนนลาดพร้าว-วังหิน ต.ลาดพร้าว อ.ลาดพร้าว กรุงเทพมหานคร 10230'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },  
    )
  };
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('พื้นที่ให้บริการของเรา'),
      ),
       body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: CameraPosition(
          target: latlng, 
          zoom: 14.0
        ),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
      ),
    );
  }

}