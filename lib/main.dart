import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator RMB',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController age = TextEditingController();
  bool gender = false;
  bool activeStatus = false;
  bool request = false;
  double rmb = 0;
  double rma = 0;
  double nm = 0;
  double proteina = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calculate),
        onPressed: () => setState(() {
          rmb = 10 * double.parse(weight.text) +
              6.25 * double.parse(height.text) -
              5 * double.parse(age.text) +
              (gender ? -161 : 5);
          if (activeStatus) {
            rma = rmb * (gender ? 1.25 : 1.3);
          } else {
            rma = rmb + (gender ? 250 : 300);
          }
          nm = rma + (request ? 500 : -500);
          proteina = double.parse(weight.text) * 1.4;
        }),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Inaltime'),
            controller: height,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Greutate'),
              controller: weight,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
            ),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Varsta'),
            controller: age,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SwitchListTile(
              title: Text(gender ? 'Femeie' : 'Barbat'),
              value: gender,
              onChanged: (x) => setState(() => gender = x),
            ),
          ),
          SwitchListTile(
            title: Text(activeStatus ? 'Activ' : 'Sedentar'),
            value: activeStatus,
            onChanged: (x) => setState(() => activeStatus = x),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SwitchListTile(
              title: Text(request ? 'Crestere' : 'Scadere'),
              value: request,
              onChanged: (x) => setState(() => request = x),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'RMB: ${rmb.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'RMA: ${rma.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Numar Magic: ${nm.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Proteina: ${proteina.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
