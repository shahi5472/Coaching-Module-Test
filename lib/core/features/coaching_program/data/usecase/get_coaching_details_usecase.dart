import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../../app/model/base/errors/failures.dart';
import '../models/coaching_details_response_model.dart';
import '../models/params/get_coaching_details_request_params.dart';
import '../repository/i_coaching_program_repository.dart';

class GetCoachingDetailsUseCase extends IUseCase<CoachingDetailsResponseModel, GetCoachingDetailsRequestParams> {
  final ICoachingProgramRepository _repository;

  GetCoachingDetailsUseCase({
    required ICoachingProgramRepository coachingProgramRepository,
  }) : _repository = coachingProgramRepository;

  @override
  Future<Either<Failure, CoachingDetailsResponseModel>> call(
    GetCoachingDetailsRequestParams params,
  ) => _repository.getCoachingDetails(params);
}
