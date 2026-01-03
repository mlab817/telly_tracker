import 'package:matomo_tracker/matomo_tracker.dart';
import 'funnels/signup_funnel.dart';

class Tracker {
  Tracker({required this.url, required this.siteId, String? visitorId}) {
    // Initialize funnels with this tracker instance
    signup = SignupFunnel(this);
    _init(visitorId: visitorId);
  }

  final String url;
  final String siteId;

  // Funnels
  late final SignupFunnel signup;

  // Matomo visitorId (optional, can update later)
  String? _visitorId;

  Future<void> _init({String? visitorId}) async {
    _visitorId = visitorId;
    await MatomoTracker.instance.initialize(
      url: url,
      siteId: siteId,
      visitorId: _visitorId,
      verbosityLevel: Level.all,
    );
  }

  /// Update visitor/user ID dynamically
  Future<void> updateVisitorId(String visitorId) async {
    _visitorId = visitorId;
    MatomoTracker.instance.setVisitorUserId(visitorId);
  }

  /// Called by funnels to actually track an event
  void track({
    required String category,
    required String action,
    String? name,
    int? value,
  }) {
    try {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: category,
          action: action,
          name: name,
          value: value,
        ),
      );
    } catch (_) {
      // Never crash the app
    }
  }
}
