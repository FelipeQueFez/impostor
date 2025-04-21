import 'package:flutter/material.dart';
import 'dart:math';
import '../feedback/tela_feedback.dart';

class TelaMostrarPalavra extends StatefulWidget {
  final List<String> participantes;
  final String palavra;
  final VoidCallback onReiniciar;

  const TelaMostrarPalavra({
    super.key,
    required this.participantes,
    required this.palavra,
    required this.onReiniciar,
  });

  @override
  State<TelaMostrarPalavra> createState() => _TelaMostrarPalavraState();
}

class _TelaMostrarPalavraState extends State<TelaMostrarPalavra> {
  int jogadorAtual = 0;
  late int impostorIndex;
  bool mostrarPalavra = false;

  @override
  void initState() {
    super.initState();
    final random = Random();
    impostorIndex = random.nextInt(widget.participantes.length);
  }

  void proximoJogador() {
    if (jogadorAtual < widget.participantes.length - 1) {
      setState(() {
        jogadorAtual++;
        mostrarPalavra = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TelaFeedback(onReiniciar: widget.onReiniciar),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nome = widget.participantes[jogadorAtual];
    final isImpostor = jogadorAtual == impostorIndex;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Jogador ${jogadorAtual + 1}/${widget.participantes.length}'),
      ),
      body: Center(
        child: mostrarPalavra
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isImpostor
                        ? 'Você NÃO recebeu a palavra!'
                        : 'Palavra: ${widget.palavra}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: proximoJogador,
                    child: const Text('Próximo jogador'),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Passar o celular para:\n\n$nome',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        mostrarPalavra = true;
                      });
                    },
                    child: const Text('Mostrar palavra'),
                  )
                ],
              ),
      ),
    );
  }
}
