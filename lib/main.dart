import 'dart:math';

import 'package:flutter/material.dart';

import 'palavra/tela_palavra.dart';
import 'servicos/csv.dart';

List<List<dynamic>> _dados = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _dados = await lerCsvDeAssets('assets/comida.csv');

  // ListView.builder(
  //             itemCount: _dados.length,
  //             itemBuilder: (context, index) {
  //               final linha = _dados[index];
  //               return ListTile(
  //                 title: Text('${linha[1]}'), // palavra
  //               );
  //             },
  //           ),

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String palavra = '';

  void _pegarNovaPalavra() {
    final random = Random();
    final indiceAleatorio = random.nextInt(_dados.length);
    final item = _dados[indiceAleatorio];

    //final categoria = item[0];
    final escolhida = item[1];

    setState(() {
      palavra = escolhida;
    });
  }

  @override
  void initState() {
    _pegarNovaPalavra();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: TelaPalavra(
          palavra: palavra,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pegarNovaPalavra,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
