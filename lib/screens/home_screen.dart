import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';
import 'orders_list_screen.dart';
import 'add_order_screen.dart';
import '../models/order.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    final yearlyTotal = orders.where((o) => o.date.year == _currentYear).fold(0.0, (s, o) => s + o.amount);
    final totalSpent = orders.fold(0.0, (s, o) => s + o.amount);
    final totalOrders = orders.length;
    final currentMonth = DateTime.now();
    final monthLabel = "${_monthName(currentMonth.month)} ${currentMonth.year}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: ListTile(
                  title: const Text('Total gasto no ano'),
                  subtitle: Text('$_currentYear'),
                  trailing: Text('R\$ ${yearlyTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: Text('Total gasto em $monthLabel'),
                  trailing: Text('R\$ ${totalSpent.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: Text('Número de pedidos em $monthLabel'),
                  trailing: Text('$totalOrders', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pedidos Recentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton(onPressed: () => _openOrdersList(context), child: const Text('Ver todos'))
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: orders.take(3).map((order) => _orderCard(order)).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddOrder(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _orderCard(Order order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.store),
        title: Text(order.establishment),
        subtitle: Text('${_formatDate(order.date)} • ${order.category}'),
        trailing: Text('R\$ ${order.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  String _formatDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _monthName(int month) {
    const names = ['janeiro','fevereiro','março','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro'];
    return names[month-1];
  }

  void _openOrdersList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrdersListScreen()));
  }

  void _openAddOrder(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddOrderScreen()));
  }
}
