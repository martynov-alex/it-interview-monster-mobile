import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:it_interview_monster/src/core/common/error_reporter/error_reporter.dart';
import 'package:it_interview_monster/src/feature/auth/data/auth_repository.dart';
import 'package:it_interview_monster/src/feature/auth/domain/entity/authentication_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    super.initialState, {
    required AuthRepository authRepository,
    required ErrorReporter errorReporter,
  }) : _authRepository = authRepository,
       _errorReporter = errorReporter {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        final _SignInWithOAuth e => _signInWithOAuth(e, emit),
        final _LogOut e => _logout(e, emit),
      },
    );
  }

  final AuthRepository _authRepository;
  final ErrorReporter _errorReporter;

  Future<void> _logout(_LogOut event, Emitter<AuthState> emit) async {
    emit(AuthState.logoutProcessing(status: state.status));

    try {
      await _authRepository.logout();
      emit(const AuthState.idle(status: AuthenticationStatus.unauthenticated));
    } on Object catch (e, stackTrace) {
      _errorReporter
          .captureException(throwable: e, stackTrace: stackTrace)
          .ignore();
      emit(
        AuthState.error(status: AuthenticationStatus.unauthenticated, error: e),
      );
    }
  }

  Future<void> _signInWithOAuth(
    _SignInWithOAuth event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(status: state.status));

    try {
      await _authRepository.signInWithOAuth();
      emit(const AuthState.idle(status: AuthenticationStatus.authenticated));
    } on Object catch (e, stackTrace) {
      _errorReporter
          .captureException(throwable: e, stackTrace: stackTrace)
          .ignore();
      emit(
        AuthState.error(status: AuthenticationStatus.unauthenticated, error: e),
      );
    }
  }
}
