import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class UserLoggedInUseCase extends IUseCase<bool, NoParams> {
  final IGlobalRepository _iGlobalRepository;

  UserLoggedInUseCase({
    required IGlobalRepository iGlobalRepository,
  }) : _iGlobalRepository = iGlobalRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) => _iGlobalRepository.userLoggedIn();
}
