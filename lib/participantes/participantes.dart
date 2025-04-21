import 'package:flutter/material.dart';

class ParticipantesPage extends StatefulWidget {
  @override
  _ParticipantesPageState createState() => _ParticipantesPageState();
}

class _ParticipantesPageState extends State<ParticipantesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _participantes = [];

  void adicionarParticipante() {
    final nome = _controller.text.trim();
    if (nome.isNotEmpty && !_participantes.contains(nome)) {
      setState(() {
        _participantes.add(nome);
        _controller.clear();
      });
    }
  }

  void removerParticipante(int index) {
    setState(() {
      _participantes.removeAt(index);
    });
  }

  void continuar() {
    // Aqui você pode passar os participantes para a próxima tela
    print("Participantes: $_participantes");
    // Navigator.push(context, ...);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogadores do Impostor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nome do participante',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: adicionarParticipante,
                ),
              ),
              onSubmitted: (_) => adicionarParticipante(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _participantes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_participantes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removerParticipante(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _participantes.isNotEmpty ? continuar : null,
              child: Text('Continuar'),
            )
          ],
        ),
      ),
    );
  }
}
