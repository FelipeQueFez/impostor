import 'dart:math';
import 'package:flutter/material.dart';

import 'palavra/tela_palavra.dart';
import 'participantes/participantes.dart';
import 'servicos/csv.dart';

List<List<dynamic>> _dados = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _dados = await lerCsvDeAssets('assets/comida.csv');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo do Impostor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ParticipantesPage(dados: _dados),
      debugShowCheckedModeBanner: false,
    );
  }
}
