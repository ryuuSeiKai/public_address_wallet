import 'wallet_connect_session.dart';

abstract class SessionStorage {
  Future store(WalletConnectSession session);

  Future<WalletConnectSession?> getSession();

  Future removeSession();
}
