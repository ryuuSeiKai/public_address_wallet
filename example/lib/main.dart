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
  final connector = WalletConnector(
      const AppInfo(name: "Mobile App", url: "https://example.mobile.com"));

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
                onPressed: () async {
                  await startConnect();
                },
                child: const Text('Start Connect'))
          ],
        ),
      ),
    );
  }

  startConnect() async {
    setState(() {
      publicAddress = '';
    });
    var address = await connector.publicAddress().catchError((onError) {
      throw onError;
    });

    // in case you want open wallet by your self
    // connector.initSession((uri) {
    //   print(uri);
    // });
    setState(() {
      publicAddress = address;
    });
  }
}
