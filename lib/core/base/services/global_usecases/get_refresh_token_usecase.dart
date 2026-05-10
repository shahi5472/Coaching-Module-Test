import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class GetRefreshTokenUseCase extends IUseCase<String, NoParams> {
  final IGlobalRepository _repository;

  GetRefreshTokenUseCase({required IGlobalRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, String>> call(NoParams params) => _repository.getRefreshToken();
}
