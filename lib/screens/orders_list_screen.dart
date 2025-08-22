import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart';

class OrdersListScreen extends ConsumerStatefulWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends ConsumerState<OrdersListScreen> {
  String _selectedMonth = 'all';

  final List<Map<String, String>> months = [
    {'value': 'all', 'label': 'Todos os meses'},
    {'value': '2024-01', 'label': 'Janeiro 2024'},
    {'value': '2024-02', 'label': 'Fevereiro 2024'},
    {'value': '2024-03', 'label': 'Março 2024'},
  ];

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    final filtered = (_selectedMonth == 'all') ? orders : orders.where((o) => _formatMonth(o.date) == _selectedMonth).toList();
    final filteredTotal = filtered.fold(0.0, (s, o) => s + o.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMonth,
              items: months.map((m) => DropdownMenuItem(value: m['value'], child: Text(m['label']!))).toList(),
              onChanged: (v) => setState(() => _selectedMonth = v ?? 'all'),
              decoration: const InputDecoration(labelText: 'Selecionar mês'),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: const Text('Total gasto no período'),
                trailing: Text('R\$ ${filteredTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('${filtered.length} pedido${filtered.length != 1 ? 's' : ''}'),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filtered.isEmpty
                  ? Center(child: Text('Nenhum pedido encontrado para este período.'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, idx) {
                        final order = filtered[idx];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.store),
                            title: Text(order.establishment),
                            subtitle: Text(_formatDate(order.date)),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('R\$ ${order.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.orange.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                                  child: Text(order.category, style: const TextStyle(color: Colors.orange, fontSize: 12)),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  String _formatMonth(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}';
}
