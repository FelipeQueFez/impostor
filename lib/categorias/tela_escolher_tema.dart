import 'dart:math';
import 'package:flutter/material.dart';
import '../palavra/tela_mostrar_palavra.dart';
import '../servicos/csv.dart';

class TelaEscolherTema extends StatefulWidget {
  final List<String> participantes;
  const TelaEscolherTema({super.key, required this.participantes});

  @override
  State<TelaEscolherTema> createState() => _TelaEscolherTemaState();
}

class _TelaEscolherTemaState extends State<TelaEscolherTema> {
  bool carregando = false;

  void _carregarTema(String tema) async {
    setState(() => carregando = true);

    String caminho;
    switch (tema) {
      case 'Comida':
        caminho = 'assets/comida.csv';
        break;
      case 'Animal':
        caminho = 'assets/animal.csv';
        break;
      case 'Filme':
        caminho = 'assets/filme.csv';
        break;
      case 'Objeto':
        caminho = 'assets/objeto.csv';
        break;
      default:
        caminho = 'assets/comida.csv';
    }

    final dados = await lerCsvDeAssets(caminho);
    final palavra = _sortearPalavra(dados);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaMostrarPalavra(
          participantes: widget.participantes,
          palavra: palavra,
          onReiniciar: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }

  String _sortearPalavra(List<List<dynamic>> dados) {
    final random = Random();
    final indice = random.nextInt(dados.length);
    return dados[indice][1];
  }

  @override
  Widget build(BuildContext context) {
    final temas = ['Comida', 'Animal', 'Filme', 'Objeto'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Escolha o Tema', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: temas.length,
              itemBuilder: (context, index) {
                final tema = temas[index];
                return Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    title: Text(
                      tema,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.deepPurple),
                    onTap: () => _carregarTema(tema),
                  ),
                );
              },
            ),
    );
  }
}
