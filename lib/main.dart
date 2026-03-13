import 'package:flutter/material.dart';

// note : CTRL-ALT-L pour formatter

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R411 TP1',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IMCCalculator(title: 'Calculateur d\'IMC'),
    );
  }
}

class IMCCalculator extends StatelessWidget {
  const IMCCalculator({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pour que le clavier passe au dessus
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // le const se répercute forcément sur les widgets à l'intérieur
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: ZoneSaisie()),
            SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: null,
              child: Text('Calculer'),
            ),
            SizedBox(height: 25.0),
            Expanded(flex: 3, child: ZoneInfo()),
          ],
        ),
      ),
    );
  }
}

class ZoneSaisie extends StatelessWidget {
  const ZoneSaisie({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card.outlined(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Poids (kg)'),
            TextEditingControllerIMC(),
            // Spacer prend le plus de place possible,
            // contrairement à SizedBox dont on doit
            // spécifier la place prise.
            Spacer(),
            Text('Taille (cm)'),
            TextEditingControllerIMC(),
          ],
        ),
      ),
    );
  }
}

class TextEditingControllerIMC extends StatefulWidget {
  const TextEditingControllerIMC({super.key});

  @override
  State<TextEditingControllerIMC> createState() =>
      _TextEditingControllerIMCState();
}

class _TextEditingControllerIMCState extends State<TextEditingControllerIMC> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(
          baseOffset: text.length,
          extentOffset: text.length,
        ),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 1,
      // bordure autour du TextField
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }
}

class ZoneInfo extends StatelessWidget {
  const ZoneInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
        // bordures arrondies
        borderRadius: BorderRadius.circular(12),
      ),
      // padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Résultat IMC'),
            Spacer(),
            Text(
              '24.6',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text('Normal', style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
