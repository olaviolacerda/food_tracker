import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart';

class AddOrderScreen extends ConsumerStatefulWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends ConsumerState<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _establishmentCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _category = '';

  @override
  void dispose() {
    _establishmentCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _establishmentCtrl,
                decoration: const InputDecoration(labelText: 'Estabelecimento', prefixIcon: Icon(Icons.store)),
                validator: (v) => v == null || v.isEmpty ? 'Informe o estabelecimento' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: 'Valor', prefixIcon: Icon(Icons.attach_money)),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v == null || v.isEmpty ? 'Informe o valor' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Data'),
                      child: TextButton(
                        onPressed: _pickDate,
                        child: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category.isEmpty ? null : _category,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items: const [
                  DropdownMenuItem(value: 'Delivery', child: Text('Delivery')),
                  DropdownMenuItem(value: 'Restaurante', child: Text('Restaurante')),
                  DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                ],
                onChanged: (v) => setState(() => _category = v ?? ''),
                validator: (v) => v == null || v.isEmpty ? 'Selecione uma categoria' : null,
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Salvar pedido'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final ordersNotifier = ref.read(ordersProvider.notifier);
      final nextId = (ref.read(ordersProvider).isEmpty) ? 1 : ref.read(ordersProvider).first.id + 1;
      final order = Order(id: nextId, establishment: _establishmentCtrl.text.trim(), amount: double.parse(_amountCtrl.text.replaceAll(',', '.')), date: _selectedDate, category: _category);
      ordersNotifier.addOrder(order);
      Navigator.of(context).pop();
    }
  }
}
