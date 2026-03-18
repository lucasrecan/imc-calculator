import 'package:flutter/material.dart';
import 'package:tp_imc_rcl4463a/models/imc_record.dart';

class ZoneInfo extends StatelessWidget {
  final IMCRecord imcRecord;

  const ZoneInfo({super.key, required this.imcRecord});

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
              imcRecord.imc.toStringAsFixed(1),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // pour éviter que les widgets bougent de place je prédéfinie
            // une hauteur parfaite pour quand le texte fait deux lignes
            SizedBox(
              height: 72,
              child: Text(
                imcRecord.qualificatif,
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