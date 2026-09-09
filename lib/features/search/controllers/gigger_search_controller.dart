import 'dart:convert';
import 'dart:developer';

import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/paginated_response_profile_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gigger_search_controller.g.dart';

@riverpod
class GiggerSearchController extends _$GiggerSearchController {
  @override
  Future<PaginatedResponseProfileOut> build({
    String? role,
    String? genre,
    String? username,
    DateTime? endDate,
    String? instrument,
    DateTime? startDate,
    required String profileUuid,
    bool proUserOnly = false,
  }) async {
    var r = await getApiV1ProfilesProfileUuidSearchUseCase(
      role: role,
      genre: genre,
      endDate: endDate,
      username: username,
      startDate: startDate,
      instrument: instrument,
      profileUuid: profileUuid,
      proUserOnly: proUserOnly,
      repo: ref.read(profileRepoProvider),
    );

    for (var e in r.items) {
      log(jsonEncode(e.availability.map((e) => e.toJson()).toList()));
    }

    return r;
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
