import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../../app/model/base/errors/failures.dart';
import '../../../../base/services/global_repository/i_global_repository.dart';
import '../data/login_response_model.dart';
import '../data/params/login_request_params.dart';

class LoginUseCase extends IUseCase<LoginResponseModel, LoginRequestParams> {
  final IGlobalRepository _repository;

  LoginUseCase({
    required IGlobalRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, LoginResponseModel>> call(
    LoginRequestParams params,
  ) => _repository.login(params);
}
