import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tp_imc_rcl4463a/widgets/history_screen.dart';
import 'package:tp_imc_rcl4463a/widgets/zone_info.dart';
import 'package:tp_imc_rcl4463a/widgets/zone_saisie.dart';

import 'package:tp_imc_rcl4463a/models/imc_model.dart';

// note : CTRL-ALT-L pour formatter

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => IMCModel(), child: const MyApp()),
  );
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

class IMCCalculator extends StatefulWidget {
  const IMCCalculator({super.key, required this.title});

  final String title;

  @override
  State<IMCCalculator> createState() => IMCCalculatorState();
}

class IMCCalculatorState extends State<IMCCalculator> {
  // final List<IMCRecord> _historique = [];
  final TextEditingController controleurPoids = TextEditingController();
  final TextEditingController controleurTaille = TextEditingController();

  void calculer() {
    // tryParse renvoie un double ou null si la conversion peut pas se faire.
    // si c'est null alors poids prends 0 (grâce au ?? 0)
    // et taille prends pas pour faire 0 / 0
    double poids = double.tryParse(controleurPoids.text) ?? 0;
    double taille = (double.tryParse(controleurTaille.text) ?? 1) / 100;
    double resultat = poids / (taille * taille);
    // context.read vient remplacer le setState
    if (resultat != 0) {
      context.read<IMCModel>().ajouterIMC(
        poids: poids,
        taille: taille * 100,
        imc: resultat,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // On regarde le provider pour savoir quoi afficher
    final model = context.watch<IMCModel>();
    return Scaffold(
      // pour que le clavier passe au dessus
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      // le const se répercute forcément sur les widgets à l'intérieur
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ZoneSaisie(
                controleurPoids: controleurPoids,
                controleurTaille: controleurTaille,
              ),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                calculer();
              },
              child: const Text('Calculer'),
            ),
            const SizedBox(height: 25.0),
            Expanded(
              flex: 3,
              child: model.historique.isEmpty
                  ? const Center(
                      child: Text("Entrez vos données pour calculer l'IMC"),
                    )
                  : ZoneInfo(imcRecord: model.historique.last),
            ),
          ],
        ),
      ),
    );
  }
}
