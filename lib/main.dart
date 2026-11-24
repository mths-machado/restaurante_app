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

  // abre a mesma tela ja preenchida e troca na mesma posicao
  Future<void> editar(int i) async {
    final p = await Navigator.push<Prato>(
      context,
      MaterialPageRoute(builder: (context) => FormPage(prato: lista[i])),
    );

    if (p != null) {
      setState(() {
        lista[i] = p;
      });
    }
  }

  // mostra confirmacao antes de apagar o prato da lista
  void excluir(int i) {
    final p = lista[i];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir prato'),
        content: Text('Deseja excluir "${p.prato}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                lista.removeAt(i);
              });
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // se nao tiver nenhum prato mostra a mensagem
      body: lista.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.restaurant, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Nenhum prato cadastrado'),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: lista.length,
              itemBuilder: (context, i) {
                // pega o prato da lista
                Prato p = lista[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.restaurant_menu),
                    title: Text(p.prato),
                    subtitle: Text('${p.categoria} - ${p.ingrediente}'),
                    onTap: () => editar(i),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => excluir(i),
                    ),
                  ),
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
