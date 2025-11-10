import 'package:dartz/dartz.dart';
import 'package:linkify/Features/settings/data/repo/reset_pass_repo.dart';
import 'package:linkify/Features/settings/data/services/reset_pass.dart';
import 'package:linkify/core/errors/failures.dart';

class ResetPassRepoImpl implements ResetPassRepo {
  final ResetPass resetPassService;

  ResetPassRepoImpl(this.resetPassService);
  @override
  Future<Either<Failure, void>> resetPass(
      {required String oldPass, required String newPass}) async {
    try {
      await resetPassService.resetPass(oldPass: oldPass, newPass: newPass);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
