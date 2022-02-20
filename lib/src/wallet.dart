/// Wallet Mobile app
class Wallet {
  /// universal link for iOS
  final String universalLink;

  const Wallet({required this.universalLink});

  static const Wallet metamask =
      Wallet(universalLink: 'https://metamask.app.link/');
  static const Wallet trustWallet =
      Wallet(universalLink: 'https://link.trustwallet.com/');
}
