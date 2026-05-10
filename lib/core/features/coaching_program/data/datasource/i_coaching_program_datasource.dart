import '../models/coaching_response_model.dart';
import '../models/params/coaching_list_request_params.dart';

abstract class ICoachingProgramDataSource {
  Future<CoachingListResponseModel> getCoachingListProgram(CoachingListRequestParams params);
}
