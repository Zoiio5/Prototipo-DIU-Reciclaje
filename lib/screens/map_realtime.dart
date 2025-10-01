import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:geolocator/geolocator.dart';
import '../services/places_service.dart';

class RealTimeMapPage extends StatefulWidget {
  const RealTimeMapPage({super.key});

  @override
  State<RealTimeMapPage> createState() => _RealTimeMapPageState();
}

class _RealTimeMapPageState extends State<RealTimeMapPage> {
  StreamSubscription<Position>? _posSub;
  latlng.LatLng? _userPos;
  final List<Marker> _placesMarkers = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionAndStart();
  }

  Future<void> _checkPermissionAndStart() async {
    // On desktop the geolocator plugin may not be available; guard with Platform
    if (!Platform.isAndroid && !Platform.isIOS) {
      // Desktop fallback: center map on a default location and skip location stream
      setState(() => _userPos = latlng.LatLng(40.4168, -3.7038)); // Madrid as default
      try {
        // Try to load nearby recycling using current position if possible
        final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        await _loadNearbyRecycling(pos);
      } catch (_) {
        // ignore if plugin missing or permissions unavailable
      }
      return;
    }

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Activa la localización en el dispositivo')));
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        // show dialog explaining why we need location and prompting to request again or open settings
        if (!mounted) return;
        final retry = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Permiso de ubicación requerido'),
            content: const Text('Necesitamos permiso de ubicación para mostrar tu posición en el mapa y puntos cercanos.'),
            actions: [
              TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Cancelar')),
              TextButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Reintentar')),
            ],
          ),
        );
        if (retry == true) {
          permission = await Geolocator.requestPermission();
        } else {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        final go = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Permiso denegado permanentemente'),
            content: const Text('Debes activar el permiso de ubicación desde la configuración de la aplicación.'),
            actions: [
              TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Cerrar')),
              TextButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Abrir ajustes')),
            ],
          ),
        );
        if (go == true) {
          await Geolocator.openAppSettings();
        }
        return;
      }

      // Permission granted
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() => _userPos = latlng.LatLng(pos.latitude, pos.longitude));
      await _loadNearbyRecycling(pos);

      _posSub = Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 5))
          .listen((Position p) {
        setState(() => _userPos = latlng.LatLng(p.latitude, p.longitude));
      });
    } on MissingPluginException {
      // Plugin not available on this platform — fallback to default position
      setState(() => _userPos = latlng.LatLng(40.4168, -3.7038));
    } catch (e) {
      // Other errors: ignore for now
    }
  }

  Future<void> _loadNearbyRecycling(Position p) async {
    try {
      final places = await PlacesService.searchRecyclingNearby(p.latitude, p.longitude, radius: 5000);
      final fm = <Marker>[];
      for (final place in places) {
        fm.add(Marker(
          point: latlng.LatLng(place.lat, place.lng),
          width: 40,
          height: 40,
          builder: (ctx) => const Icon(Icons.recycling, color: Colors.green),
        ));
      }
      setState(() {
        _placesMarkers.clear();
        _placesMarkers.addAll(fm);
      });
    } catch (e) {
      // ignore
    }
  }

  @override
  void dispose() {
    _posSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final center = _userPos ?? latlng.LatLng(0, 0);
    final markers = <Marker>[];
    if (_userPos != null) {
      markers.add(Marker(
        point: _userPos!,
        width: 40,
        height: 40,
        builder: (ctx) => const Icon(Icons.person_pin_circle, color: Colors.blue, size: 36),
      ));
    }
    markers.addAll(_placesMarkers);

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa en tiempo real (OSM)')),
      body: FlutterMap(
        options: MapOptions(center: center, zoom: 14),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markers),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () async {
          final pos = await Geolocator.getCurrentPosition();
          await _loadNearbyRecycling(pos);
          if (!mounted) return;
          // Safe: checked mounted above. Suppress analyzer warning about using
          // BuildContext across async gaps.
          // ignore: use_build_context_synchronously
          final messenger = ScaffoldMessenger.of(context);
          messenger.showSnackBar(const SnackBar(content: Text('Puntos de reciclaje actualizados')));
        },
      ),
    );
  }
}
