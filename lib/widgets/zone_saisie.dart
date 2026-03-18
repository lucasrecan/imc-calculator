import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Poids (kg)'),
            TextField(
              controller: controleurPoids,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number, // Affiche le pavé numérique
            ),
            // Spacer prend le plus de place possible,
            // contrairement à SizedBox dont on doit
            // spécifier la place prise.
            const Spacer(),
            const Text('Taille (cm)'),
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