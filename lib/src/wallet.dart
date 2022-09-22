/// Wallet Mobile app
/// universal link & deeplink should end with '/'
class Wallet {
  /// universal link for iOS
  final String universalLink;

  /// deeplink for android
  final String? deeplink;

  const Wallet({required this.universalLink, this.deeplink});

  static const Wallet metamask = Wallet(
      universalLink: 'https://metamask.app.link', deeplink: 'metamask://');
  static const Wallet trustWallet = Wallet(
      universalLink: 'https://link.trustwallet.com/', deeplink: 'trust://');
  static const Wallet rainbowMe =
      Wallet(universalLink: 'https://rainbow.me/', deeplink: 'rainbow://');
  static const Wallet talken = Wallet(universalLink: 'https://talken.io');
}
