import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(const PosAtendimentoApp());
}

class PosAtendimentoApp extends StatelessWidget {
  const PosAtendimentoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acompanhamento Pós-Consulta',
      home: const RecomendacoesPage(),
    );
  }
}

class RecomendacoesPage extends StatefulWidget {
  const RecomendacoesPage({super.key});

  @override
  _RecomendacoesPageState createState() => _RecomendacoesPageState();
}

class _RecomendacoesPageState extends State<RecomendacoesPage> {
  List<Map<String, dynamic>> _recomendacoes = [];

  @override
  void initState() {
    super.initState();
    _loadRecomendacoes();
  }

  void _loadRecomendacoes() async {
    final data = await DatabaseHelper().getRecomendacoes();
    setState(() {
      _recomendacoes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acompanhamento Pós-Consulta'),
      ),
      body: _recomendacoes.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma recomendação disponível.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _recomendacoes.length,
              itemBuilder: (context, index) {
                final recomendacao = _recomendacoes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recomendacao['titulo'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recomendacao['descricao'],
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Paciente: ${recomendacao['paciente'] ?? 'Não informado'}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
