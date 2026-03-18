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

class IMCCalculator extends StatefulWidget {
  const IMCCalculator({super.key, required this.title});

  final String title;

  @override
  State<IMCCalculator> createState() => IMCCalculatorState();
}

class IMCCalculatorState extends State<IMCCalculator> {
  final TextEditingController controleurPoids = TextEditingController();
  final TextEditingController controleurTaille = TextEditingController();
  double _imc = 0.0;

  void calculer() {
    // tryParse renvoie un double ou null si la conversion peut pas se faire.
    // si c'est null alors poids prends 0 (grâce au ?? 0)
    // et taille prends pas pour faire 0 / 0
    double poids = double.tryParse(controleurPoids.text) ?? 0;
    double taille = (double.tryParse(controleurTaille.text) ?? 1) / 100;
    double resultat = poids / (taille * taille);

    // bonne pratique de mettre en interne à setState le bout de code qui
    // nécessite de reconstruire.
    setState(() {
      _imc = resultat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pour que le clavier passe au dessus
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              child: Text('Calculer'),
            ),
            const SizedBox(height: 25.0),
            Expanded(flex: 3, child: ZoneInfo(imc: _imc)),
          ],
        ),
      ),
    );
  }
}

class ZoneSaisie extends StatelessWidget {
  final TextEditingController controleurTaille;
  final TextEditingController controleurPoids;

  const ZoneSaisie({
    super.key,
    required this.controleurTaille,
    required this.controleurPoids,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Poids (kg)'),
            TextField(
              controller: controleurPoids,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number, // Affiche le pavé numérique
            ),
            // Spacer prend le plus de place possible,
            // contrairement à SizedBox dont on doit
            // spécifier la place prise.
            Spacer(),
            Text('Taille (cm)'),
            TextField(
              controller: controleurTaille,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

class ZoneInfo extends StatelessWidget {
  final double imc;

  const ZoneInfo({super.key, required this.imc});

  // getter qui permet de simplement appeler qualificatif comme une variable
  String get qualificatif {
    switch (imc) {
      case 0:
        return "";
      case < 16.5:
        return "Insuffisance pondérale sévère";
      case < 18.5:
        return "Insuffisance pondérale modérée";
      case < 24.9:
        return "Corpulence normale";
      case < 29.9:
        return "Surpoids";
      case < 34.5:
        return "Obésité modérée";
      case < 39.9:
        return "Obésité sévère";
      default:
        return "Obésité morbide";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
        // bordures arrondies
        borderRadius: BorderRadius.circular(12),
      ),
      // padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Résultat IMC'),
            const Spacer(),
            Text(
              // donne un string avec 1 chiffre après la virgule
              imc.toStringAsFixed(1),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // pour éviter que les widgets bougent de place je prédéfinie
            // une hauteur parfaite pour quand le texte fait deux lignes
            SizedBox(
              height: 72,
              child: Text(
                qualificatif,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class BoutonCalculer extends StatefulWidget {
//   const BoutonCalculer({super.key});
//
//   @override
//   State<BoutonCalculer> createState() => EtatBoutonCalculer();
// }
//
// class EtatBoutonCalculer extends State<BoutonCalculer> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(onPressed: () {}, child: Text('Calculer'));
//   }
// }
