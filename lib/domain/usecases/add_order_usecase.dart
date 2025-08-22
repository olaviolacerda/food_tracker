import '../../models/order.dart';
import '../repositories/orders_repository.dart';

class AddOrderUseCase {
  final OrdersRepository repository;

  AddOrderUseCase(this.repository);

  void call(Order order) => repository.addOrder(order);
}
