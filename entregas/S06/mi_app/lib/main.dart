import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Colores principales
const kFondo = Color(0xFFFFFFFF);
const kTexto = Color(0xFF252936);
const kMuted = Color(0xFF8A8D98);
const kMorado = Color(0xFF7A5CE6);
const kBorde = Color(0xFFE5E5EA);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explora destinos',

      theme: ThemeData(
        scaffoldBackgroundColor: kFondo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMorado,
          brightness: Brightness.light,
        ),
      ),

      home: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Título
              const Text(
                'Explora destinos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kTexto,
                ),
              ),

              const SizedBox(height: 5),

              // Subtítulo
              const Text(
                'Encuentra tu próximo lugar favorito',
                style: TextStyle(
                  fontSize: 13,
                  color: kMuted,
                ),
              ),

              const SizedBox(height: 18),

              // Barra de búsqueda
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: kBorde,
                  ),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar lugar turístico',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: kMuted,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: kMuted,
                      size: 20,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: kMuted,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Destinos
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.35,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  destinationCard(
                    'Petén',
                    'assets/images/peten.jpg',
                  ),
                  destinationCard(
                    'Izabal',
                    'assets/images/izabal.jpg',
                  ),
                  destinationCard(
                    'Quetzaltenango',
                    'assets/images/quetzaltenango.jpg',
                  ),
                  destinationCard(
                    'Cobán',
                    'assets/images/coban.jpg',
                  ),
                  destinationCard(
                    'El Progreso',
                    'assets/images/progreso.jpg',
                  ),
                  destinationCard(
                    'Quiché',
                    'assets/images/quiche.jpg',
                  ),
                ],
              ),
            ],
          ),
        ),

        // Barra de navegación inferior
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: kMorado,
          unselectedItemColor: kMuted,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              activeIcon: Icon(Icons.location_on),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Reservaciones',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

// Tarjeta para cada destino
Widget destinationCard(String nombre, String imagen) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Stack(
      fit: StackFit.expand,
      children: [
        // Imagen
        Image.asset(
          imagen,
          fit: BoxFit.cover,
        ),

        // Oscurece un poco la parte inferior
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),
          ),
        ),

        // Nombre del destino
        Positioned(
          left: 10,
          bottom: 8,
          child: Text(
            nombre,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}