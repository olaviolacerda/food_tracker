class InMemoryAuthDataSource {
  String? _currentUserId = 'alice';

  String? get currentUserId => _currentUserId;
  void setCurrentUserId(String? id) => _currentUserId = id;
}
