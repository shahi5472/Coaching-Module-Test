import 'package:coaching_module_test/core/features/coaching_program/data/models/coaching_response_model.dart';
import 'package:coaching_module_test/core/features/coaching_program/data/models/params/coaching_list_request_params.dart';

import '../../../../../app/model/base/errors/failures.dart';
import '../../../../../app/network/api_path.dart';
import '../../../../../app/network/dio_wrapper.dart';
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
}
