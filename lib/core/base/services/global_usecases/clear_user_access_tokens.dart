import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class ClearUserAccessTokensUseCase extends IUseCase<bool, NoParams> {
  final IGlobalRepository _globalRepository;

  ClearUserAccessTokensUseCase({
    required IGlobalRepository globalRepository,
  }) : _globalRepository = globalRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) => _globalRepository.clearUserAccessTokens();
}
