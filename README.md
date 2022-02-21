## Introduction
WalletConnect connects mobile & web applications to supported mobile wallets. The WalletConnect session is started by scanning a QR code (desktop) or by clicking an application deep link (mobile).

Once installed, you can simply get verified address from wallet.

## Usage
```dart
    /// Create a connector
    var connector = WalletConnector(
        const AppInfo(name: "Mobile App", url: "https://example.mobile.com"));
    /// create wallet need open 
    var rainbowMe = const Wallet(universalLink: 'https://rainbow.me/', deeplink: 'rainbow://');
    /// Get address
    var address = await connector.publicAddress(wallet: rainbowMe).catchError((onError) {
      throw onError;
    });
```

Currently, package already have `Wallet.metamask`, `Wallet.trustWallet` and `Wallet.rainbowMe` constants.

```dart
    /// package open Metamask by default
    var address = await connector.publicAddress().catchError((onError) {
        throw onError;
    });
```

If you want open wallet by your self, use `initSession` and get uri
```dart
    connector.initSession((uri) {
        // use session uri and connect to wallet by your way
        print(uri);
    });
```

## Credits

- [Tai Phan Van](https://github.com/phanvantai)
- [Tomas Verhelst](https://github.com/rootsoft)
- [Tom Friml](https://github.com/3ph)  
- [All Contributors](../../contributors)