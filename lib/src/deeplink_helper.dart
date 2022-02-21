import 'dart:io';

import 'package:public_address_wallet/src/wallet.dart';

class DeeplinkHelper {
  static const wcBridge = 'wc?uri=';

  static String getDeeplink({required Wallet wallet, required String uri}) {
    if (Platform.isIOS) {
      return wallet.universalLink + wcBridge + Uri.encodeComponent(uri);
    } else {
      if (wallet.deeplink != null && wallet.deeplink!.isNotEmpty) {
        return wallet.deeplink! + wcBridge + Uri.encodeComponent(uri);
      } else {
        return uri;
      }
    }
  }
}
