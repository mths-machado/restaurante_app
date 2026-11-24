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
      debugShowCheckedModeBanner: false,
      // tema com cores quentes pra combinar com restaurante
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
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

  // mostra um aviso rapido na parte de baixo da tela
  void mostrarAviso(String texto) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text(texto),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
      if (!mounted) return;
      mostrarAviso('Prato salvo!');
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
      if (!mounted) return;
      mostrarAviso('Prato atualizado!');
    }
  }

  // mostra confirmacao antes de apagar o prato da lista
  void excluir(int i) {
    final p = lista[i];
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        icon: const Icon(Icons.delete_outline, color: Colors.red, size: 32),
        title: const Text('Excluir prato'),
        content: Text(
          'Deseja excluir "${p.prato}" do cardápio?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() {
                lista.removeAt(i);
              });
              mostrarAviso('Prato excluído!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      // fundo clarinho quente pra destacar os cards brancos
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu, size: 22),
            SizedBox(width: 8),
            Text(
              'Restaurante',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      // se nao tiver nenhum prato mostra o icone grande e a mensagem
      body: lista.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: cores.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.restaurant,
                        size: 72,
                        color: cores.primary,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Nenhum prato cadastrado',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Toque em "Novo prato" para montar o cardápio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                // cabecalho simples mostrando quantos pratos tem cadastrados
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cardápio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: cores.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          lista.length == 1
                              ? '1 prato'
                              : '${lista.length} pratos',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: cores.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 90),
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      // pega o prato da lista e a primeira letra pro avatar
                      Prato p = lista[i];
                      String letra =
                          p.prato.isNotEmpty ? p.prato[0].toUpperCase() : '?';

                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black26,
                        margin: const EdgeInsets.only(bottom: 12),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () => editar(i),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor: cores.primaryContainer,
                                      foregroundColor: cores.primary,
                                      child: Text(
                                        letra,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p.prato,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          // categoria em destaque num chip compacto
                                          Chip(
                                            label: Text(
                                              p.categoria,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: cores.onPrimaryContainer,
                                              ),
                                            ),
                                            backgroundColor:
                                                cores.primaryContainer,
                                            side: BorderSide.none,
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.kitchen_outlined,
                                                size: 15,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  p.ingrediente,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 18, color: Colors.grey[200]),
                                // botoes de editar e excluir bem visiveis no card
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () => editar(i),
                                      icon: const Icon(Icons.edit, size: 18),
                                      label: const Text('Editar'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: cores.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    TextButton.icon(
                                      onPressed: () => excluir(i),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        size: 18,
                                      ),
                                      label: const Text('Excluir'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: abrirForm,
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(Icons.add),
        label: const Text(
          'Novo prato',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
