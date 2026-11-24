import 'package:material_ui/material_ui.dart';
import 'prato.dart';

class FormPage extends StatefulWidget {
  // se vier preenchido, a tela funciona como edicao
  final Prato? prato;

  const FormPage({super.key, this.prato});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // controllers dos campos de texto
  late TextEditingController ctrlPrato;
  late TextEditingController ctrlCat;
  late TextEditingController ctrlIng;

  @override
  void initState() {
    super.initState();
    // inicia os controllers ja com o texto do prato quando for edicao
    ctrlPrato = TextEditingController(text: widget.prato?.prato ?? '');
    ctrlCat = TextEditingController(text: widget.prato?.categoria ?? '');
    ctrlIng = TextEditingController(text: widget.prato?.ingrediente ?? '');
  }

  @override
  void dispose() {
    ctrlPrato.dispose();
    ctrlCat.dispose();
    ctrlIng.dispose();
    super.dispose();
  }

  // valida os campos, monta o prato e volta pra tela inicial
  void salvar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Prato p = Prato(
      prato: ctrlPrato.text.trim(),
      categoria: ctrlCat.text.trim(),
      ingrediente: ctrlIng.text.trim(),
    );
    Navigator.pop(context, p);
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.prato != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar Prato' : 'Novo Prato'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: ctrlPrato,
                decoration: const InputDecoration(
                  labelText: 'Prato',
                  prefixIcon: Icon(Icons.restaurant_menu),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ctrlCat,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ctrlIng,
                decoration: const InputDecoration(
                  labelText: 'Ingrediente principal',
                  prefixIcon: Icon(Icons.kitchen),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: salvar,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
