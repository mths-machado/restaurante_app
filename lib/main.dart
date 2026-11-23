import 'package:material_ui/material_ui.dart';
import 'form_page.dart';
import 'prato.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // lista de pratos em memoria, ja comeca com um exemplo
  List<Prato> lista = [
    Prato(
      prato: 'Risoto',
      categoria: 'Principal',
      ingrediente: 'Arroz',
    ),
  ];

  // abre a tela de cadastro e adiciona o prato quando voltar
  Future<void> abrirForm() async {
    final p = await Navigator.push<Prato>(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );

    if (p != null) {
      setState(() {
        lista.add(p);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // se nao tiver nenhum prato mostra a mensagem
      body: lista.isEmpty
          ? const Center(
              child: Text('Nenhum prato cadastrado'),
            )
          : ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, i) {
                // pega o prato da lista
                Prato p = lista[i];
                return ListTile(
                  title: Text(p.prato),
                  subtitle: Text('${p.categoria} - ${p.ingrediente}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
