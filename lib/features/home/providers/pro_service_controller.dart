import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pro_service_controller.g.dart';

class ProService {
  final String thumbnail;
  final String name;
  final String title;
  final String description;
  final String location;
  final String kilometers;

  ProService({
    required this.thumbnail,
    required this.name,
    required this.title,
    required this.description,
    required this.location,
    required this.kilometers,
  });
}

@Riverpod(keepAlive: true)
class ProServiceController extends _$ProServiceController {
  @override
  Future<List<ProService>> build() async {
    return [
      ProService(
        thumbnail: Assets.proServices.a1.path,
        name: 'The_Soundz',
        title: 'Recording and Mastering',
        location: 'San Francisco',
        description: 'Record your Album with a sp ...',
        kilometers: '234 km',
      ),
      ProService(
        thumbnail: Assets.proServices.a2.path,
        name: 'MarinaFaMercato',
        title: 'Professional Liuther',
        location: 'Milan',
        description: 'Liuther for your Gear!',
        kilometers: '2.2 km',
      ),
      ProService(
        thumbnail: Assets.proServices.a3.path,
        name: 'ARDaBELLa',
        title: 'Videomaking, Photo Servi ...',
        location: 'Paris, France',
        description: 'Your professional content creator',
        kilometers: '56 km',
      ),
      ProService(
        thumbnail: Assets.proServices.a4.path,
        name: 'Stage_Masssster',
        title: 'Stage Gear and Lights',
        location: ' Cavarina, USA',
        description: 'Only best gear for your concert!',
        kilometers: '560 km',
      ),
    ];
  }
}
