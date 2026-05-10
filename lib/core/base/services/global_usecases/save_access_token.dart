import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class SaveAccessToken extends IUseCase<bool, String> {
  final IGlobalRepository _globalRepository;

  SaveAccessToken({
    required IGlobalRepository globalRepository,
  }) : _globalRepository = globalRepository;

  @override
  Future<Either<Failure, bool>> call(String params) {
    return _globalRepository.saveAccessToken(params);
  }
}
