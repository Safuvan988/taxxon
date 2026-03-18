import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxxon/services/database_service.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;
  final bool isPasswordVisible;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage,
    this.isPasswordVisible = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
    bool? isPasswordVisible,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final DatabaseService _dbService;

  AuthNotifier(this._dbService) : super(AuthState());

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final user = await _dbService.getUser(username, password);

      if (user != null) {
        state = state.copyWith(isLoading: false, isAuthenticated: true);
      } else {
        state = state.copyWith(
          isLoading: false, 
          isAuthenticated: false, 
          errorMessage: "Invalid username or password",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Database error: ${e.toString()}",
      );
    }
  }

  Future<bool> signup(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _dbService.createUser(username, password);
      state = state.copyWith(isLoading: false);
      if (!success) {
        state = state.copyWith(errorMessage: "Username already exists or database error");
      }
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Database error: ${e.toString()}",
      );
      return false;
    }
  }

  void logout() {
    state = AuthState();
  }
}

final databaseServiceProvider = Provider((ref) => DatabaseService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return AuthNotifier(dbService);
});
