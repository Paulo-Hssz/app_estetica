import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pos_consulta.db');
    return await openDatabase(
      path,
      version: 5, // Incrementado para recriar o banco
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Recriar o banco ao atualizar a versão
        await db.execute('DROP TABLE IF EXISTS recomendacoes');
        await _onCreate(db, newVersion);
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recomendacoes(
        id INTEGER PRIMARY KEY,
        paciente TEXT,
        titulo TEXT,
        descricao TEXT
      )
    ''');

    // Inserir os novos dados
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Higiene e Cuidados',
      'descricao': 'Realize higiene adequada na área tratada.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Cuidados Alimentares',
      'descricao': 'Evite alimentos gordurosos e pesados.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Exposição Solar',
      'descricao': 'Evite exposição solar direta por 48 horas.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Hidratação',
      'descricao': 'Beba pelo menos 2 litros de água por dia.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Acompanhamento e Retorno',
      'descricao': 'Retorne à clínica em caso de dúvidas ou reações.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Evitar Produtos e Atividades Não Recomendados',
      'descricao': 'Não use produtos químicos agressivos ou faça exercícios intensos.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Descanso',
      'descricao': 'Descanse adequadamente após o procedimento.',
    });
    await db.insert('recomendacoes', {
      'paciente': 'João Silva',
      'titulo': 'Medicamentos e Suplementos',
      'descricao': 'Tome os medicamentos e suplementos prescritos pelo médico.',
    });
  }

  Future<List<Map<String, dynamic>>> getRecomendacoes() async {
    Database db = await database;
    return await db.query('recomendacoes');
  }
}
