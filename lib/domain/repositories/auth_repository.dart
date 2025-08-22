abstract class AuthRepository {
  /// Returns the current authenticated user id, or null if unauthenticated
  String? getCurrentUserId();
}
