import 'package:oz_player/domain/repository/login/revoke_reason_repository.dart';

class RevokeReasonUsecase {
  final RevokeReasonRepository _repository;

  RevokeReasonUsecase(this._repository);

  Future<void> execute(int index) async {
    final reason = _getFieldName(index);
    if (reason.isNotEmpty) {
      await _repository.updateRevokeReason(reason);
    }
  }

  String _getFieldName(int index) {
    switch (index) {
      case 0:
        return 'serviceNotUsed';
      case 1:
        return 'musicDislike';
      case 2:
        return 'privacyConcern';
      case 3:
        return 'missingFeature';
      case 4:
        return 'appError';
      default:
        return '';
    }
  }
}
