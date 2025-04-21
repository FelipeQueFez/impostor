import 'package:flutter/material.dart';

import 'participantes/participantes.dart';
import 'servicos/csv.dart';

List<List<dynamic>> _comidas = [];
List<List<dynamic>> _animais = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _comidas = await lerCsvDeAssets('assets/comida.csv');
  _animais = await lerCsvDeAssets('assets/animal.csv');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo do Impostor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: ParticipantesPage(dados: _comidas),
      debugShowCheckedModeBanner: false,
    );
  }
}
