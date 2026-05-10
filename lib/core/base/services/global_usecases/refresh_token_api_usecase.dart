import 'package:dartz/dartz.dart';

import '../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../app/model/base/errors/failures.dart';
import '../global_repository/i_global_repository.dart';

class RefreshTokenApiUseCase extends IUseCase<dynamic, dynamic> {
  final IGlobalRepository _repository;

  RefreshTokenApiUseCase({required IGlobalRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, dynamic>> call(dynamic params) => _repository.getNewAccessToken(params);
}
