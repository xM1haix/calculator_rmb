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
  final _height = TextEditingController(),
      _weight = TextEditingController(),
      _age = TextEditingController();
  var _gender = false,
      _activeStatus = false,
      _request = false,
      _rmb = 0.0,
      _rma = 0.0,
      _nm = 0.0,
      _proteina = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      floatingActionButton: FloatingActionButton(
        onPressed: _calculate,
        child: const Icon(Icons.calculate),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Inaltime'),
            controller: _height,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Greutate'),
              controller: _weight,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
            ),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Varsta'),
            controller: _age,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SwitchListTile(
              title: Text(_gender ? 'Femeie' : 'Barbat'),
              value: _gender,
              onChanged: (x) => setState(() => _gender = x),
            ),
          ),
          SwitchListTile(
            title: Text(_activeStatus ? 'Activ' : 'Sedentar'),
            value: _activeStatus,
            onChanged: (x) => setState(() => _activeStatus = x),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SwitchListTile(
              title: Text(_request ? 'Crestere' : 'Scadere'),
              value: _request,
              onChanged: (x) => setState(() => _request = x),
            ),
          ),
          Center(
            child: Column(
              children: [
                'RMB: ${_rmb.toStringAsFixed(2)}',
                'RMA: ${_rma.toStringAsFixed(2)}',
                'Numar Magic: ${_nm.toStringAsFixed(2)}',
                'Proteina: ${_proteina.toStringAsFixed(2)}',
              ]
                  .map(
                    (e) => Text(e, style: const TextStyle(fontSize: 20)),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _calculate() {
    final w = double.parse(_weight.text);
    setState(() {
      _rmb = 10 * w +
          6.25 * double.parse(_height.text) -
          5 * double.parse(_age.text) +
          (_gender ? -161 : 5);
      final v = _activeStatus
          ? _gender
              ? 1.25
              : 1.3
          : _gender
              ? 250
              : 300;
      _rma = _rmb * v;
      _nm = _rma + (_request ? 500 : -500);
      _proteina = w * 1.4;
    });
  }
}
