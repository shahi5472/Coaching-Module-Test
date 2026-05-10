import 'package:coaching_module_test/app/model/base/errors/failures.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/coaching_response_model.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/coaching_list_request_params.dart';
import 'package:dartz/dartz.dart';

import '../datasource/i_coaching_program_datasource.dart';
import 'i_coaching_program_repository.dart';

class CoachingProgramRepositoryImpl extends ICoachingProgramRepository {
  final ICoachingProgramDataSource _remoteDataSource;

  CoachingProgramRepositoryImpl({
    required ICoachingProgramDataSource dataSource,
  }) : _remoteDataSource = dataSource;

  @override
  Future<Either<Failure, CoachingListResponseModel>> getCoachingListProgram(CoachingListRequestParams params) async {
    try {
      return right(await _remoteDataSource.getCoachingListProgram(params));
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
