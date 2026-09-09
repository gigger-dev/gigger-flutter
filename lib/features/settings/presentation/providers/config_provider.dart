import 'package:mobile_gigger_app/features/settings/data/settings_provider.dart';
import 'package:mobile_gigger_app/features/settings/domain/settings_use_case.dart';
import 'package:mobile_gigger_app/models/server_config_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_provider.g.dart';

@Riverpod(keepAlive: true)
class Config extends _$Config {
  @override
  Future<ServerConfigOut?> build() => _getData();

  Future<ServerConfigOut?> reset() async {
    var data = await _getData();
    if (data == null) return state.valueOrNull;

    state = AsyncData(data);
    return data;
  }

  Future<ServerConfigOut?> _getData() async {
    try {
      return getApiV1ConfigUseCase(ref.read(settingsRepoProvider));
    } catch (e) {
      return null;
    }
  }
}
