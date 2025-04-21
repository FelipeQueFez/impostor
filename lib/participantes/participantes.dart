import 'dart:math';
import 'package:flutter/material.dart';
import '../palavra/tela_mostrar_palavra.dart';

class ParticipantesPage extends StatefulWidget {
  final List<List<dynamic>> dados;

  const ParticipantesPage({super.key, required this.dados});

  @override
  State<ParticipantesPage> createState() => _ParticipantesPageState();
}

class _ParticipantesPageState extends State<ParticipantesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _participantes = [];

  void _adicionarParticipante() {
    final nome = _controller.text.trim();
    if (nome.isNotEmpty && !_participantes.contains(nome)) {
      setState(() {
        _participantes.add(nome);
        _controller.clear();
      });
    }
  }

  void _continuar() {
    final palavra = _sortearPalavra();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaMostrarPalavra(
          participantes: _participantes,
          palavra: palavra,
        ),
      ),
    );
  }

  String _sortearPalavra() {
    final random = Random();
    final indice = random.nextInt(widget.dados.length);
    return widget.dados[indice][1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogadores do Impostor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nome do participante',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarParticipante,
                ),
              ),
              onSubmitted: (_) => _adicionarParticipante(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _participantes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_participantes[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _participantes.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _participantes.isNotEmpty ? _continuar : null,
              child: const Text('Continuar'),
            )
          ],
        ),
      ),
    );
  }
}
