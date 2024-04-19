import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkRepository {
  final PendingDynamicLinkData? _initialLink;
  bool _initialLinkHandled = false;

  DynamicLinkRepository(this._initialLink);

  PendingDynamicLinkData? handleInitialLink() {
    _initialLinkHandled = true;
    return _initialLink;
  }

  bool get initialLinkHandled => _initialLinkHandled;
}
