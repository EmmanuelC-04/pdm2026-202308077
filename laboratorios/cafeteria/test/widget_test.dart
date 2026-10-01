import 'package:cafeteria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Muestra los tres productos del pedido', (tester) async {
    await tester.pumpWidget(const CafeteriaApp());

    expect(find.text('Mi pedido'), findsOneWidget);
    expect(find.text('Café'), findsOneWidget);
    expect(find.text('Q10.00'), findsOneWidget);
    expect(find.text('Sándwich'), findsOneWidget);
    expect(find.text('Q25.00'), findsOneWidget);
    expect(find.text('Jugo'), findsOneWidget);
    expect(find.text('Q12.00'), findsOneWidget);
    expect(find.text('0'), findsNWidgets(3));
    expect(find.text('Q0.00'), findsOneWidget);
  });

  testWidgets('Actualiza cada cantidad sin bajar de cero', (tester) async {
    await tester.pumpWidget(const CafeteriaApp());

    final cafe = find.ancestor(
      of: find.text('Café'),
      matching: find.byType(ProductoPedido),
    );
    final sandwich = find.ancestor(
      of: find.text('Sándwich'),
      matching: find.byType(ProductoPedido),
    );
    final restarCafe = find.descendant(
      of: cafe,
      matching: find.widgetWithText(OutlinedButton, '-1'),
    );

    expect(tester.widget<OutlinedButton>(restarCafe).onPressed, isNull);

    await tester.tap(
      find.descendant(
        of: cafe,
        matching: find.widgetWithText(OutlinedButton, '+1'),
      ),
    );
    await tester.pump();

    expect(find.descendant(of: cafe, matching: find.text('1')), findsOneWidget);
    expect(
      find.descendant(of: sandwich, matching: find.text('0')),
      findsOneWidget,
    );

    await tester.tap(restarCafe);
    await tester.pump();

    expect(find.descendant(of: cafe, matching: find.text('0')), findsOneWidget);
    expect(tester.widget<OutlinedButton>(restarCafe).onPressed, isNull);
    expect(find.text('Café'), findsOneWidget);
    expect(find.text('Sándwich'), findsOneWidget);
    expect(find.text('Jugo'), findsOneWidget);
  });

  testWidgets('Calcula el total y vacía el pedido', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CafeteriaApp());

    Finder producto(String nombre) => find.ancestor(
      of: find.text(nombre),
      matching: find.byType(ProductoPedido),
    );

    Finder cantidad(String nombre, int valor) =>
        find.descendant(of: producto(nombre), matching: find.text('$valor'));

    Future<void> pulsar(String nombre, String control, [int veces = 1]) async {
      final boton = find.descendant(
        of: producto(nombre),
        matching: find.widgetWithText(OutlinedButton, control),
      );

      for (var i = 0; i < veces; i++) {
        await tester.tap(boton);
        await tester.pump();
      }
    }

    await pulsar('Jugo', '-1');
    expect(find.text('Q0.00'), findsOneWidget);
    expect(find.text('0'), findsNWidgets(3));

    await pulsar('Café', '+1', 2);
    await pulsar('Sándwich', '+1');
    await pulsar('Jugo', '+1');
    expect(cantidad('Café', 2), findsOneWidget);
    expect(cantidad('Sándwich', 1), findsOneWidget);
    expect(cantidad('Jugo', 1), findsOneWidget);
    expect(find.text('Q57.00'), findsOneWidget);

    await pulsar('Café', '-1');
    expect(cantidad('Café', 1), findsOneWidget);
    expect(find.text('Q47.00'), findsOneWidget);

    await tester.tap(find.text('Vaciar pedido'));
    await tester.pump();
    expect(find.text('Q0.00'), findsOneWidget);
    expect(find.text('0'), findsNWidgets(3));
    expect(find.text('Café'), findsOneWidget);
    expect(find.text('Sándwich'), findsOneWidget);
    expect(find.text('Jugo'), findsOneWidget);
  });
}
