import 'package:coaching_module_test/app/model/base/errors/failures.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/coaching_details_response_model.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/coaching_response_model.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/coaching_list_request_params.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/get_coaching_details_request_params.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/get_coaching_feed_list_request_params.dart';
import 'package:dartz/dartz.dart';

import '../datasource/i_coaching_program_datasource.dart';
import '../models/get_feed__list_response_model.dart';
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

  @override
  Future<Either<Failure, CoachingDetailsResponseModel>> getCoachingDetails(GetCoachingDetailsRequestParams params) async {
    try {
      return right(await _remoteDataSource.getCoachingDetails(params));
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetFeedListResponseModel>> getCoachingFeedList(GetCoachingFeedListRequestParams params) async {
    try {
      return right(await _remoteDataSource.getCoachingFeedList(params));
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
