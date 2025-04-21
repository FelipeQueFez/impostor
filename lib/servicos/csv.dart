import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

Future<List<List<dynamic>>> lerCsvDeAssets(String caminhoDoArquivo) async {
  final dadosCsv = await rootBundle.loadString(caminhoDoArquivo);
  final converter = const CsvToListConverter(fieldDelimiter: ',', eol: '\n');
  final List<List<dynamic>> lista = converter.convert(dadosCsv);
  return lista;
}
