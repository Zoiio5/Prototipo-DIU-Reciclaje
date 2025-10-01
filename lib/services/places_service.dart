import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class RecyclingPlace {
  final double lat;
  final double lng;
  final String name;
  final String? vicinity;

  RecyclingPlace({required this.lat, required this.lng, required this.name, this.vicinity});
}

class PlacesService {
  // Busca lugares cercanos del tipo 'recycling' usando Places API (requiere clave)
  // Devuelve lista de RecyclingPlace con coordenadas y nombre
  static Future<List<RecyclingPlace>> searchRecyclingNearby(double latitude, double longitude, {int radius = 5000}) async {
    final latlng = '$latitude,$longitude';
    final uri = Uri.https('maps.googleapis.com', '/maps/api/place/nearbysearch/json', {
      'location': latlng,
      'radius': radius.toString(),
      'keyword': 'recycling|recycling center|recycle',
      'key': kGoogleApiKey,
    });

    final resp = await http.get(uri);
    if (resp.statusCode != 200) return [];

    final Map<String, dynamic> json = jsonDecode(resp.body);
    if (json['status'] != 'OK') return [];

    final results = json['results'] as List<dynamic>;
    final places = <RecyclingPlace>[];
    for (final r in results) {
      final geometry = r['geometry'];
      final loc = geometry['location'];
      final lat = (loc['lat'] as num).toDouble();
      final lng = (loc['lng'] as num).toDouble();
      final name = r['name'] as String? ?? 'Punto de reciclaje';
      final vicinity = r['vicinity'] as String? ?? '';

      places.add(RecyclingPlace(lat: lat, lng: lng, name: name, vicinity: vicinity));
    }

    return places;
  }
}
