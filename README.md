## Introduction
WalletConnect connects mobile & web applications to supported mobile wallets. The WalletConnect session is started by scanning a QR code (desktop) or by clicking an application deep link (mobile).

Once installed, you can simply get verified address from wallet.

## Usage
```dart
    /// Create a connector
    var connector = WalletConnector(
        const AppInfo(name: "Mobile App", url: "https://example.mobile.com"));
    /// Get address
    var address = await connector.publicAddress().catchError((onError) {
        throw onError;
    });
```