import 'package:dartz/dartz.dart';

import '../../../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../../../app/model/base/errors/failures.dart';
import '../models/coaching_note_response_model.dart';
import '../models/params/coaching_note_request_params.dart';
import '../repository/i_coaching_program_repository.dart';

class GetCoachingNoteUseCase extends IUseCase<CoachingNoteResponseModel, CoachingNoteRequestParams> {
  final ICoachingProgramRepository _repository;

  GetCoachingNoteUseCase({
    required ICoachingProgramRepository coachingProgramRepository,
  }) : _repository = coachingProgramRepository;

  @override
  Future<Either<Failure, CoachingNoteResponseModel>> call(
    CoachingNoteRequestParams params,
  ) => _repository.getCoachingNoteList(params);
}
