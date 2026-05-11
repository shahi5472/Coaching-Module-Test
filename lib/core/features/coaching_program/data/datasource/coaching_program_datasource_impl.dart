import 'package:coaching_module_test/core/features/coaching_program/data/models/coaching_details_response_model.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/coaching_response_model.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/coaching_list_request_params.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/get_coaching_details_request_params.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/get_coaching_feed_list_request_params.dart';

import '../../../../../app/model/base/errors/failures.dart';
import '../../../../../app/network/api_path.dart';
import '../../../../../app/network/dio_wrapper.dart';
import '../models/get_feed__list_response_model.dart';
import 'i_coaching_program_datasource.dart';

class CoachingProgramDataSourceImpl extends ICoachingProgramDataSource {
  final IDioWrapper _dio;

  CoachingProgramDataSourceImpl({required IDioWrapper dio}) : _dio = dio;

  @override
  Future<CoachingListResponseModel> getCoachingListProgram(CoachingListRequestParams params) async {
    final result = await _dio.onGet(api: APIPaths.coachingList, queryParameters: params.toJson);
    if (result.data != null) {
      return CoachingListResponseModel.fromJson(result.data);
    }
    throw const ServerFailure("Something went wrong");
  }

  @override
  Future<CoachingDetailsResponseModel> getCoachingDetails(GetCoachingDetailsRequestParams params) async {
    final result = await _dio.onGet(api: APIPaths.coachingDetails(params.programId), queryParameters: params.toJson);
    if (result.data != null) {
      return CoachingDetailsResponseModel.fromJson(result.data);
    }
    throw const ServerFailure("Something went wrong");
  }

  @override
  Future<GetFeedListResponseModel> getCoachingFeedList(GetCoachingFeedListRequestParams params) async {
    final result = await _dio.onGet(
      api: APIPaths.coachingFeedList(programId: params.programId, sessionId: params.sessionId),
    );
    if (result.data != null) {
      return GetFeedListResponseModel.fromJson(result.data);
    }
    throw const ServerFailure("Something went wrong");
  }
}
