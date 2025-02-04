

import 'package:oz_player/data/source/login/revoke_reason_data_source.dart';
import 'package:oz_player/domain/repository/login/revoke_reason_repository.dart';

class RevokeReasonRepositoryImpl implements RevokeReasonRepository {
  final RevokeReasonDataSource _dataSource;

  RevokeReasonRepositoryImpl(this._dataSource);

  @override
  Future<void> updateRevokeReason(String reason) async {
    return _dataSource.updateRevokeReason(reason);
  }
}