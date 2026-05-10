import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class SaveRefreshToken extends IUseCase<bool, String> {
  final IGlobalRepository _repository;

  SaveRefreshToken({required IGlobalRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(String params) => _repository.saveRefreshToken(params);
}
