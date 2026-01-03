import 'package:telly_tracker/src/tracker.dart';

abstract class Funnel<T extends Enum> {
  final Tracker tracker;

  Funnel(this.tracker);

  String get category;

  void step(T step, {String? name, int? value}) {
    try {
      tracker.track(
        category: category,
        action: step.name,
        name: name,
        value: value,
      );
    } catch (_) {
      // never break the app
    }
  }
}
