import 'package:flutter/material.dart';

class CentroCard extends StatelessWidget {
  final String nombre;
  final String distancia;
  final String materiales;

  const CentroCard({
    super.key,
    required this.nombre,
    required this.distancia,
    required this.materiales,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.recycling, color: Colors.teal, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text("$distancia · $materiales", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Buscar ubicación",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://i.ibb.co/kSgRzDz/sf-map.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CentroCard(nombre: "Centro de Reciclaje EcoVida", distancia: "1.2 km", materiales: "Plástico, Vidrio"),
                  SizedBox(height: 8),
                  CentroCard(nombre: "Punto Limpio Verde", distancia: "2.5 km", materiales: "Papel, Cartón"),
                  SizedBox(height: 8),
                  CentroCard(nombre: "Reciclaje Innova", distancia: "3.8 km", materiales: "Metal, Electrónicos"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
