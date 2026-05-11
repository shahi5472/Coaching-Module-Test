import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/errors/failures.dart';
import '../models/coaching_details_response_model.dart';
import '../models/coaching_response_model.dart';
import '../models/get_feed__list_response_model.dart';
import '../models/params/coaching_list_request_params.dart';
import '../models/params/get_coaching_details_request_params.dart';
import '../models/params/get_coaching_feed_list_request_params.dart';

abstract class ICoachingProgramRepository {
  Future<Either<Failure, CoachingListResponseModel>> getCoachingListProgram(CoachingListRequestParams params);

  Future<Either<Failure, CoachingDetailsResponseModel>> getCoachingDetails(GetCoachingDetailsRequestParams params);

  Future<Either<Failure, GetFeedListResponseModel>> getCoachingFeedList(GetCoachingFeedListRequestParams params);
}
