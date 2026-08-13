import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Colores principales
const kFondo = Color(0xFFFFFFFF);
const kTexto = Color(0xFF171717);
const kMuted = Color(0xFF6F6F6F);
const kSuperficie = Color(0xFFF5F5F5);
const kVerde = Color(0xFFD7FF67);
const kNegroTarjeta = Color(0xFF202020);
const kGrisTarjeta = Color(0xFF4B4B4B);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pantalla 2',
      theme: ThemeData(
        scaffoldBackgroundColor: kFondo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kVerde,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Encabezado
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE9E9E9),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: kTexto,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Add money',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: kTexto,
                            ),
                          ),
                        ),
                        const SizedBox(width: 42),
                      ],
                    ),

                    const SizedBox(height: 26),

                    // Título de tarjetas
                    const Text(
                      'Select card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTexto,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Tarjetas
                    SizedBox(
                      height: 124,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          bankCard(
                            backgroundColor: kVerde,
                            textColor: const Color(0xFF626C3B),
                            title: 'Debit card',
                            number: '•••• 4568',
                            selected: true,
                            showVisa: false,
                          ),

                          const SizedBox(width: 12),

                          bankCard(
                            backgroundColor: kNegroTarjeta,
                            textColor: Colors.white,
                            title: 'Credit card',
                            number: '•••• 2478',
                            selected: false,
                            showVisa: true,
                          ),

                          const SizedBox(width: 12),

                          bankCard(
                            backgroundColor: kGrisTarjeta,
                            textColor: Colors.white,
                            title: 'Bank card',
                            number: '•••• 9012',
                            selected: false,
                            showVisa: false,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Título de métodos
                    const Text(
                      'Add money to Neobank',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTexto,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Métodos para agregar dinero
                    moneyMethod(
                      Icons.savings_outlined,
                      'Move your direct deposit',
                    ),

                    const SizedBox(height: 10),

                    moneyMethod(
                      Icons.swap_horiz,
                      'Transfer from other banks',
                    ),

                    const SizedBox(height: 10),

                    moneyMethod(
                      Icons.apple,
                      'Apple Pay',
                    ),

                    const SizedBox(height: 10),

                    moneyMethod(
                      Icons.credit_card_outlined,
                      'Debit / Credit Card',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget bankCard({
  required Color backgroundColor,
  required Color textColor,
  required String title,
  required String number,
  required bool selected,
  required bool showVisa,
}) {
  return Container(
    width: 126,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(22),

      // Borde para la tarjeta seleccionada
      border: selected
          ? Border.all(
              color: kTexto,
              width: 3,
            )
          : null,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Círculo de selección
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: selected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Color(0xFF3D4B1C),
                      ),
                    )
                  : null,
            ),
          ],
        ),

        const Spacer(),

        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          number,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

// Cada método para agregar dinero
Widget moneyMethod(IconData icon, String title) {
  return Container(
    height: 58,
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    decoration: BoxDecoration(
      color: kSuperficie,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: kTexto,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kTexto,
            ),
          ),
        ),

        const Icon(
          Icons.chevron_right,
          size: 24,
          color: kMuted,
        ),
      ],
    ),
  );
}