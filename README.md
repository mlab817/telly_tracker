# Telly Tracker

A Dart package for tracking events in the Tellycom mobile app using Matomo analytics.

## Features

- 🎯 Structured event tracking with funnels
- 🔄 Built on [Matomo Tracker](https://pub.dev/packages/matomo_tracker)
- 🛡️ Error-safe tracking that won't crash your app
- 📊 Easy-to-extend funnel system for tracking user journeys

## Installation

Add `telly_tracker` to your `pubspec.yaml`:

```yaml
dependencies:
  telly_tracker:
    git:
      url: https://github.com/mlab817/telly_tracker.git
```

## Usage

### Initialize the Tracker

```dart
import 'package:telly_tracker/telly_tracker.dart';

final tracker = Tracker(
  url: 'https://your-matomo-instance.com',
  siteId: '1',
  visitorId: 'optional-user-id', // Optional
);
```

### Use Built-in Funnels

```dart
// Track signup events
tracker.signup.intent();
tracker.signup.submitted('premium');
```

### Create Custom Funnels

Extend the `Funnel` class to create your own tracking funnels:

```dart
enum CheckoutStep { started, payment, completed }

class CheckoutFunnel extends Funnel<CheckoutStep> {
  CheckoutFunnel(super.tracker);

  @override
  String get category => 'Checkout';

  void started() => step(CheckoutStep.started);
  void payment(String method) => step(CheckoutStep.payment, name: method);
  void completed(double amount) => step(CheckoutStep.completed, value: amount.toInt());
}
```

Then add it to your `Tracker` class:

```dart
class Tracker {
  // ... existing code ...
  late final CheckoutFunnel checkout;

  Tracker({required this.url, required this.siteId, String? visitorId}) {
    signup = SignupFunnel(this);
    checkout = CheckoutFunnel(this); // Add your custom funnel
    _init(visitorId: visitorId);
  }
}
```

### Update Visitor ID

```dart
await tracker.updateVisitorId('new-user-id');
```

## Author

**Lester Bolotaolo**  
Tellycom LLC  
[mlab817@gmail.com](mailto:mlab817@gmail.com)  
[https://tellycom.io](https://tellycom.io)
