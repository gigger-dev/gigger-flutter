import 'package:mobile_gigger_app/models/call_to_action.dart';

extension CallToActionExtension on CallToAction {
  int get index {
    return switch (name) {
      'None' => 0,
      'Send me a DM!' => 1,
      'Suport me!' => 2,
      'Check my availability!' => 3,
      'See my Fab9!' => 4,
      'Call Me (your phone on Gigger)!' => 5,
      'Visit my website!' => 6,
      'Custom' => 7,
      String() => 0,
    };
  }
}
