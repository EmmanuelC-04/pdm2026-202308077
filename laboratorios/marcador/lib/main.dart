import 'package:flutter/material.dart';

void main() {
  runApp(const MarcadorApp());
}

class MarcadorApp extends StatelessWidget {
  const MarcadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarcadorPage(),
    );
  }
}

class MarcadorPage extends StatefulWidget {
  const MarcadorPage({super.key});

  @override
  State<MarcadorPage> createState() => _MarcadorPageState();
}

class _MarcadorPageState extends State<MarcadorPage> {
  int equipoA = 0;
  int equipoB = 0;

  String get mensaje {
    if (equipoA > equipoB) {
      return 'Va ganando Equipo A';
    } else if (equipoB > equipoA) {
      return 'Va ganando Equipo B';
    } else {
      return 'Empate';
    }
  }

  void reiniciar() {
    setState(() {
      equipoA = 0;
      equipoB = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador Deportivo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              mensaje,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: tarjetaEquipo(
                      nombre: 'Equipo A',
                      puntos: equipoA,
                      color: equipoA > equipoB
                          ? Colors.green
                          : Colors.grey,
                      sumar: () {
                        setState(() {
                          equipoA++;
                        });
                      },
                      restar: () {
                        if (equipoA > 0) {
                          setState(() {
                            equipoA--;
                          });
                        }
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: tarjetaEquipo(
                      nombre: 'Equipo B',
                      puntos: equipoB,
                      color: equipoB > equipoA
                          ? Colors.green
                          : Colors.grey,
                      sumar: () {
                        setState(() {
                          equipoB++;
                        });
                      },
                      restar: () {
                        if (equipoB > 0) {
                          setState(() {
                            equipoB--;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: reiniciar,
              child: const Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }

    Widget tarjetaEquipo({
    required String nombre,
    required int puntos,
    required Color color,
    required VoidCallback sumar,
    required VoidCallback restar,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            '$puntos',
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: sumar,
                child: const Text('+1'),
              ),

              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: restar,
                child: const Text('-1'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}