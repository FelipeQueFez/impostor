import 'package:flutter/material.dart';

class TelaFeedback extends StatelessWidget {
  final VoidCallback onReiniciar;

  const TelaFeedback({super.key, required this.onReiniciar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hora do Jogo!')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Todos os jogadores já viram a palavra (ou não 😈).',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'Agora conversem entre vocês e tentem descobrir quem é o impostor!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Jogar novamente'),
                onPressed: () {
                  onReiniciar();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
