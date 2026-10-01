import 'package:flutter/material.dart';

void main() => runApp(const CafeteriaApp());

class CafeteriaApp extends StatelessWidget {
  const CafeteriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi pedido',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF795548),
          surface: const Color(0xFFF8F5F1),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F5F1),
        useMaterial3: true,
      ),
      home: const PantallaPedido(),
    );
  }
}

class PantallaPedido extends StatefulWidget {
  const PantallaPedido({super.key});

  @override
  State<PantallaPedido> createState() => _PantallaPedidoState();
}

class _PantallaPedidoState extends State<PantallaPedido> {
  static const double _precioCafe = 10;
  static const double _precioSandwich = 25;
  static const double _precioJugo = 12;

  final List<int> _cantidades = [0, 0, 0];

  double get _total =>
      _precioCafe * _cantidades[0] +
      _precioSandwich * _cantidades[1] +
      _precioJugo * _cantidades[2];

  void _cambiarCantidad(int indice, int cambio) {
    if (_cantidades[indice] + cambio < 0) return;

    setState(() {
      _cantidades[indice] += cambio;
    });
  }

  void _vaciarPedido() {
    setState(() {
      _cantidades.fillRange(0, _cantidades.length, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi pedido'),
        backgroundColor: colorScheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const Text(
              'Elige tus productos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text('Ajusta las cantidades para preparar tu pedido.'),
            const SizedBox(height: 24),
            ProductoPedido(
              nombre: 'Café',
              precio: _precioCafe,
              cantidad: _cantidades[0],
              onRestar: _cantidades[0] > 0
                  ? () => _cambiarCantidad(0, -1)
                  : null,
              onSumar: () => _cambiarCantidad(0, 1),
            ),
            const SizedBox(height: 12),
            ProductoPedido(
              nombre: 'Sándwich',
              precio: _precioSandwich,
              cantidad: _cantidades[1],
              onRestar: _cantidades[1] > 0
                  ? () => _cambiarCantidad(1, -1)
                  : null,
              onSumar: () => _cambiarCantidad(1, 1),
            ),
            const SizedBox(height: 12),
            ProductoPedido(
              nombre: 'Jugo',
              precio: _precioJugo,
              cantidad: _cantidades[2],
              onRestar: _cantidades[2] > 0
                  ? () => _cambiarCantidad(2, -1)
                  : null,
              onSumar: () => _cambiarCantidad(2, 1),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Q${_total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _vaciarPedido,
                    child: const Text('Vaciar pedido'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductoPedido extends StatelessWidget {
  const ProductoPedido({
    super.key,
    required this.nombre,
    required this.precio,
    this.cantidad = 0,
    this.onRestar,
    this.onSumar,
  });

  final String nombre;
  final double precio;
  final int cantidad;
  final VoidCallback? onRestar;
  final VoidCallback? onSumar;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    nombre,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'Q${precio.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cantidad',
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: onRestar,
                      child: const Text('-1'),
                    ),
                    SizedBox(
                      width: 48,
                      child: Text(
                        '$cantidad',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    OutlinedButton(onPressed: onSumar, child: const Text('+1')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
