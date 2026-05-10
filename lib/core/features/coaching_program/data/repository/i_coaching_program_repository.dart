import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/errors/failures.dart';
import '../models/coaching_response_model.dart';
import '../models/params/coaching_list_request_params.dart';

abstract class ICoachingProgramRepository {
  Future<Either<Failure, CoachingListResponseModel>> getCoachingListProgram(CoachingListRequestParams params);
}
