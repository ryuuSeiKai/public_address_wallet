import 'package:flutter/material.dart';
import 'package:public_address_wallet/public_address_wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String publicAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (publicAddress.isNotEmpty) ...{
              const Text("Public address in wallet:"),
              Text(
                publicAddress,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            },
            TextButton(
                onPressed: () => startConnect(Wallet.metamask),
                child: const Text('Start Connect Metamask')),
            TextButton(
                onPressed: () => startConnect(Wallet.trustWallet),
                child: const Text('Start Connect Trust Wallet')),
            TextButton(
                onPressed: () => startConnect(Wallet.rainbowMe),
                child: const Text('Start Connect Rainbow')),
            ElevatedButton(
                onPressed: publicAddress != ""
                    ? () async {
                        final data = await ethProvider.signTransaction(
                            from: publicAddress, to: "");
                        print(data);
                      }
                    : null,
                child: Text('Action Wallet')),
            TextButton(
                onPressed: () => startConnect(Wallet.rainbowMe),
                child: const Text('Action Wallet'))
          ],
        ),
      ),
    );
  }

  bool isConnected = false;

  late EthereumWalletConnectProvider ethProvider;

  startConnect(Wallet wallet) async {
    final connector = WalletConnector(
        AppInfo(name: "Mobile App", url: "https://example.mobile.com"));
    setState(() {
      publicAddress = '';
    });
    var address =
        await connector.publicAddress(wallet: wallet).catchError((onError) {
      print(onError);
      throw onError;
    });
    print(address);
    ethProvider = EthereumWalletConnectProvider(connector.connector);
    // in case you want open wallet by your self
    // connector.initSession((uri) {
    //   print(uri);
    // });
    setState(() {
      publicAddress = address;
    });
  }
}
