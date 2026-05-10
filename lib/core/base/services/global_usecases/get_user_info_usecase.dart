import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../../../features/auth/services/data/login_response_model.dart';
import '../global_repository/i_global_repository.dart';

class GetUserInfoUseCase extends IUseCase<LoginResponseModel, NoParams> {
  final IGlobalRepository _iGlobalRepository;

  GetUserInfoUseCase({required IGlobalRepository iGlobalRepository}) : _iGlobalRepository = iGlobalRepository;

  @override
  Future<Either<Failure, LoginResponseModel>> call(NoParams params) {
    return _iGlobalRepository.getUserInformation();
  }
}
