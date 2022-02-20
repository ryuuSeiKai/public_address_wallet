import 'dart:async';

import 'package:public_address_wallet/src/app_info.dart';
import 'package:public_address_wallet/src/deeplink_helper.dart';
import 'package:public_address_wallet/src/wallet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletConnector {
  final WalletConnect connector;
  final AppInfo? appInfo;

  const WalletConnector._internal({
    required this.connector,
    required this.appInfo,
  });

  factory WalletConnector({String? bridge, AppInfo? appInfo}) {
    final connector = WalletConnect(
      bridge: bridge ?? 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: appInfo?.name ?? 'WalletConnect',
        description: appInfo?.description ?? 'WalletConnect Developer App',
        url: appInfo?.url ?? 'https://walletconnect.org',
        icons: appInfo?.icons ??
            [
              'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ],
      ),
    );

    return WalletConnector._internal(
      connector: connector,
      appInfo: appInfo,
    );
  }

  Future<String> publicAddress({Wallet wallet = Wallet.metamask}) async {
    if (!connector.connected) {
      final session = await connector.createSession(
        onDisplayUri: (uri) async {
          var deeplink = DeeplinkHelper.getDeeplink(wallet: wallet, uri: uri);
          if (!await launch(deeplink, forceSafariVC: false)) {
            throw 'Could not open $deeplink';
          }
        },
      ).catchError((onError) {
        throw onError;
      });
      if (session.accounts.isNotEmpty) {
        var address = session.accounts.first;
        return address;
      } else {
        return '';
      }
    } else {
      var oldSession = await connector.sessionStorage?.getSession();
      if (oldSession != null && oldSession.accounts.isNotEmpty) {
        return oldSession.accounts.first;
      } else {
        return '';
      }
    }
  }
}
