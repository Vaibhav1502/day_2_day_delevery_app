import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({super.key});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // Define map coordinates for the route
  static const LatLng pickupLocation = LatLng(19.1199, 72.8654); // Andheri East
  static const LatLng deliveryLocation = LatLng(19.0960, 72.8751); // The Lalit
  static const LatLng midPoint1 = LatLng(19.1090, 72.8850);
  static const LatLng midPoint2 = LatLng(19.0990, 72.8860);

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _setPolylines();
  }

  void _setMarkers() async {
    final BitmapDescriptor pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/pickup_marker.png');
    final BitmapDescriptor deliveryIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/delivery_marker.png');

    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('pickupLocation'),
        position: pickupLocation,
        icon: pickupIcon,
      ));
      _markers.add(Marker(
        markerId: const MarkerId('deliveryLocation'),
        position: deliveryLocation,
        icon: deliveryIcon,
      ));
    });
  }

  void _setPolylines() {
    setState(() {
      _polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: const [pickupLocation, LatLng(19.1105, 72.8600), midPoint1, midPoint2, deliveryLocation],
        color: Colors.red,
        width: 3,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 220,
        maxHeight: 400,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        panel: _buildPanelContent(),
        body: _buildMap(),
      ),
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(19.108, 72.875), // Center between points
            zoom: 14.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _markers,
          polylines: _polylines,
        ),
        Positioned(
          top: 50,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPanelContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildUserInfo(),
          const Divider(height: 32),
          _buildDeliveryInfo(),
          const Spacer(),
          _buildStartButton(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        const Icon(Icons.person_outline, color: Colors.red, size: 24),
        const SizedBox(width: 8),
        const Text('Aman Sharma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const Spacer(),
        const Icon(Icons.phone_outlined, color: Colors.red, size: 24),
        const SizedBox(width: 8),
        const Text('9999988888', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on_outlined, color: Colors.red, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(
                '201/D, Ananta Apts, Near Jal Bhawan, Andheri 400069',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.send_rounded, size: 18),
        label: const Text('Start'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFDE188),
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}