class InMemoryAuthDataSource {
  String? _currentUserId = 'olavio';

  String? get currentUserId => _currentUserId;
  void setCurrentUserId(String? id) => _currentUserId = id;
}
