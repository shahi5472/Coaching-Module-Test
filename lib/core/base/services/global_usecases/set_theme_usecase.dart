import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class SetThemeUseCase extends IUseCase<void, ThemeMode> {
  final IGlobalRepository _repository;

  SetThemeUseCase({required IGlobalRepository globalRepository}) : _repository = globalRepository;

  @override
  Future<Either<Failure, void>> call(ThemeMode params) => _repository.setTheme(theme: params);
}
