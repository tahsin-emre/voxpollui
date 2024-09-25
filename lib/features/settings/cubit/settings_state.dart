import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class SettingsState extends Equatable {
  const SettingsState({this.theme});

  SettingsState copyWith({ThemeData? theme}) {
    return SettingsState(theme: theme ?? this.theme);
  }

  final ThemeData? theme;

  @override
  List<Object> get props => [];
}
