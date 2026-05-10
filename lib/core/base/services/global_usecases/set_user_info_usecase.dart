import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../../../features/auth/services/data/login_response_model.dart';
import '../global_repository/i_global_repository.dart';

class SetUserInfoUseCase extends IUseCase<bool, LoginResponseModel> {
  final IGlobalRepository _iGlobalRepository;

  SetUserInfoUseCase({required IGlobalRepository iGlobalRepository}) : _iGlobalRepository = iGlobalRepository;

  @override
  Future<Either<Failure, bool>> call(LoginResponseModel params) {
    return _iGlobalRepository.setUserInformation(params);
  }
}
