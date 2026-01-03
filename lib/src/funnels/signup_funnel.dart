import 'package:telly_tracker/src/funnels/funnel.dart';

enum SignupStep { intent, submitted }

class SignupFunnel extends Funnel<SignupStep> {
  SignupFunnel(super.tracker);

  @override
  String get category => 'Signup';

  // Instance methods (not static) so they can access the tracker instance
  void intent() => step(SignupStep.intent);
  void submitted(String accountType) =>
      step(SignupStep.submitted, name: accountType);
}
