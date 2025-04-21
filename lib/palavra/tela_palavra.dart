import 'package:flutter/material.dart';

class TelaPalavra extends StatelessWidget {
  const TelaPalavra({
    super.key,
    required this.palavra,
  });

  final String palavra;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Palavras do Jogo',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
      body: Center(
        child: Text(
          palavra.substring(0, 1).toUpperCase() + palavra.substring(1),
          style: TextStyle(
            fontSize: 80,
          ),
        ),
      ),
    );
  }
}
