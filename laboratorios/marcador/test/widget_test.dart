import 'package:flutter_test/flutter_test.dart';

import 'package:marcador/main.dart';

void main() {
  testWidgets('El marcador inicia en empate con ambos equipos en cero',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MarcadorApp());

    expect(find.text('Equipo A'), findsOneWidget);
    expect(find.text('Equipo B'), findsOneWidget);

    expect(find.text('Empate'), findsOneWidget);

    expect(find.text('0'), findsNWidgets(2));
  });
}