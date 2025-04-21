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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
            'Jogador ${jogadorAtual + 1}/${widget.participantes.length}',
            style: const TextStyle(fontSize: 22)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: mostrarPalavra
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isImpostor ? Icons.visibility_off : Icons.visibility,
                      size: 80,
                      color: isImpostor ? Colors.redAccent : Colors.green,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      isImpostor
                          ? 'Você NÃO recebeu a palavra!'
                          : 'Palavra:\n"${widget.palavra}"',
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: proximoJogador,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Próximo jogador',
                          style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person,
                        size: 80, color: Colors.deepPurple),
                    const SizedBox(height: 24),
                    Text(
                      'Passe o celular para:\n\n$nome',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          mostrarPalavra = true;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye),
                      label: const Text('Mostrar palavra',
                          style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
