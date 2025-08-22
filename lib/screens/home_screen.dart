import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';
import 'orders_list_screen.dart';
import 'add_order_screen.dart';
import '../models/order.dart';
import '../utils/category_colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // now persisted in providers so other screens keep the selection
  // local vars are removed; use providers

  @override
  Widget build(BuildContext context) {
  final orders = ref.watch(ordersProvider);
  final now = DateTime.now();
  final currentYear = now.year;
  final currentMonth = now.month;
  final yearlyTotal = orders.where((o) => o.date.year == currentYear).fold(0.0, (s, o) => s + o.amount);

  // monthly totals/counts filtered by the current year and current month (always show vigente)
  final monthFiltered = orders.where((o) => o.date.year == currentYear && o.date.month == currentMonth).toList();
  final totalSpent = monthFiltered.fold(0.0, (s, o) => s + o.amount);
  final totalOrders = monthFiltered.length;
  // month label not used currently

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
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: const Text('Total gasto no ano'),
                  trailing: Text('R\$ ${yearlyTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red.shade700)),
                ),
              ),
              const SizedBox(height: 12),

              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total do mês ($totalOrders)'),
                    ],
                  ),
                  trailing: Text('R\$ ${totalSpent.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red.shade700)),
                ),
              ),
              const SizedBox(height: 12),
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
        backgroundColor: categoryColor('delivery'),
        onPressed: () => _openAddOrder(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _orderCard(Order order) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: categoryColorWithAlpha(order.category, 0.12),
          child: Icon(Icons.store, color: categoryColor(order.category)),
        ),
        title: Text(order.establishment),
        subtitle: Row(
          children: [
            Text(_formatDate(order.date)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: categoryColorWithAlpha(order.category, 0.12), borderRadius: BorderRadius.circular(12)),
              child: Text(order.category, style: TextStyle(color: categoryColor(order.category), fontSize: 12)),
            ),
          ],
        ),
        trailing: Text('R\$ ${order.amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade700)),
      ),
    );
  }

  // category colors are provided by lib/utils/category_colors.dart

  String _formatDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  // month name helper is provided where needed by other screens

  void _openOrdersList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrdersListScreen()));
  }

  void _openAddOrder(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddOrderScreen()));
  }
}
