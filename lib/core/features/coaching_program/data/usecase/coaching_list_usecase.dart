import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../../app/model/base/errors/failures.dart';
import '../models/coaching_response_model.dart';
import '../models/params/coaching_list_request_params.dart';
import '../repository/i_coaching_program_repository.dart';

class CoachingListUseCase extends IUseCase<CoachingListResponseModel, CoachingListRequestParams> {
  final ICoachingProgramRepository _repository;

  CoachingListUseCase({
    required ICoachingProgramRepository coachingProgramRepository,
  }) : _repository = coachingProgramRepository;

  @override
  Future<Either<Failure, CoachingListResponseModel>> call(CoachingListRequestParams params) => _repository.getCoachingListProgram(params);
}
