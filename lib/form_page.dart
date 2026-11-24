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
    final cores = Theme.of(context).colorScheme;
    final bordaCampo = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          editando ? 'Editar Prato' : 'Novo Prato',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              // icone no topo pra deixar a tela mais bonita
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cores.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  editando ? Icons.edit_note : Icons.restaurant_menu,
                  size: 42,
                  color: cores.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                editando
                    ? 'Altere as informações do prato'
                    : 'Preencha os dados do novo prato',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 18),
              // card branco envolvendo os campos do formulario
              Card(
                color: Colors.white,
                elevation: 2,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ctrlPrato,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Prato',
                          hintText: 'Ex: Risoto de cogumelos',
                          filled: true,
                          fillColor: const Color(0xFFFFFAF7),
                          prefixIcon: Icon(
                            Icons.restaurant_menu,
                            color: cores.primary,
                          ),
                          border: bordaCampo,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Preencha este campo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: ctrlCat,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Categoria',
                          hintText: 'Ex: Entrada, Principal, Sobremesa',
                          filled: true,
                          fillColor: const Color(0xFFFFFAF7),
                          prefixIcon: Icon(
                            Icons.category,
                            color: cores.primary,
                          ),
                          border: bordaCampo,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Preencha este campo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: ctrlIng,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Ingrediente principal',
                          hintText: 'Ex: Arroz arbóreo',
                          filled: true,
                          fillColor: const Color(0xFFFFFAF7),
                          prefixIcon: Icon(
                            Icons.kitchen,
                            color: cores.primary,
                          ),
                          border: bordaCampo,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Preencha este campo';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // botao largo pra salvar o prato
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cores.primary,
                    foregroundColor: cores.onPrimary,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
