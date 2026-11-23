import 'package:material_ui/material_ui.dart';
import 'prato.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // controllers dos campos de texto
  final ctrlPrato = TextEditingController();
  final ctrlCat = TextEditingController();
  final ctrlIng = TextEditingController();

  @override
  void dispose() {
    ctrlPrato.dispose();
    ctrlCat.dispose();
    ctrlIng.dispose();
    super.dispose();
  }

  // monta o prato e volta pra tela inicial
  void salvar() {
    Prato p = Prato(
      prato: ctrlPrato.text,
      categoria: ctrlCat.text,
      ingrediente: ctrlIng.text,
    );
    Navigator.pop(context, p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Prato'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: ctrlPrato,
                decoration: const InputDecoration(labelText: 'Prato'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ctrlCat,
                decoration: const InputDecoration(labelText: 'Categoria'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ctrlIng,
                decoration: const InputDecoration(
                  labelText: 'Ingrediente principal',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
