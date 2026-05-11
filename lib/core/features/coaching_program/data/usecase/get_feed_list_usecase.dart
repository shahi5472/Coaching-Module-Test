import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../../app/model/base/errors/failures.dart';
import '../models/get_feed__list_response_model.dart';
import '../models/params/get_coaching_feed_list_request_params.dart';
import '../repository/i_coaching_program_repository.dart';

class GetFeedListUseCase extends IUseCase<GetFeedListResponseModel, GetCoachingFeedListRequestParams> {
  final ICoachingProgramRepository _repository;

  GetFeedListUseCase({
    required ICoachingProgramRepository coachingProgramRepository,
  }) : _repository = coachingProgramRepository;

  @override
  Future<Either<Failure, GetFeedListResponseModel>> call(
    GetCoachingFeedListRequestParams params,
  ) => _repository.getCoachingFeedList(params);
}
