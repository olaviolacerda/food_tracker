import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final InMemoryAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  String? getCurrentUserId() => dataSource.currentUserId;
}
