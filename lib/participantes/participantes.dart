import 'package:flutter/material.dart';
import '../categorias/tela_escolher_tema.dart';

class ParticipantesPage extends StatefulWidget {
  const ParticipantesPage({super.key});

  @override
  State<ParticipantesPage> createState() => _ParticipantesPageState();
}

class _ParticipantesPageState extends State<ParticipantesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _participantes = [];

  void resetarParticipantes() {
    setState(() {
      _participantes.clear();
      _controller.clear();
    });
  }

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaEscolherTema(participantes: _participantes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title:
            const Text('Jogadores do Impostor', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Digite o nome do participante',
                hintStyle: const TextStyle(fontSize: 18),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.person_add,
                      size: 28, color: Colors.deepPurple),
                  onPressed: _adicionarParticipante,
                ),
              ),
              onSubmitted: (_) => _adicionarParticipante(),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _participantes.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum participante adicionado.',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _participantes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(
                              _participantes[index],
                              style: const TextStyle(fontSize: 22),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 26, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  _participantes.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward, size: 28),
              label: const Text(
                'Continuar',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _participantes.isNotEmpty ? _continuar : null,
            ),
          ],
        ),
      ),
    );
  }
}
