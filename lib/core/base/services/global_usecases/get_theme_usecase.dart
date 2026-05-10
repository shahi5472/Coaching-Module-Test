import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class GetThemeUseCase extends IUseCase<ThemeMode, NoParams> {
  final IGlobalRepository _repository;

  GetThemeUseCase({required IGlobalRepository globalRepository}) : _repository = globalRepository;

  @override
  Future<Either<Failure, ThemeMode>> call(NoParams params) => _repository.getTheme();
}
