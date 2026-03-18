import 'package:flutter/material.dart';

import '../models/imc_record.dart';

class HistoryScreen extends StatelessWidget {
  final List<IMCRecord> historique;
  final void Function(int) onDelete;

  const HistoryScreen({
    super.key,
    required this.historique,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: historique.isEmpty
            ? const Center(
                child: Text(
                  "L'historique est vide.",
                  style: TextStyle(fontSize: 24),
                ),
              )
            : ListView.builder(
                itemCount: historique.length,
                itemBuilder: (context, index) {
                  // le plus récent en haut
                  final record = historique[historique.length - 1 - index];
                  // le Dismissible a besoin d'une clé pour savoir quel
                  // widget supprimer précisément
                  return Dismissible(
                    key: Key(record.hashCode.toString()),
                    onDismissed: (direction) {
                      onDelete(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Élément supprimé')),
                      );
                    },
                    // fond pour le swipe vers la droite (icône à gauche)
                    background: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      // Aligné à gauche
                      padding: const EdgeInsets.only(left: 20.0),
                      // Marge interne gauche
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    // fond pour le swipe vers la gauche (icône à droite)
                    secondaryBackground: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      // Aligné à droite
                      padding: const EdgeInsets.only(right: 20.0),
                      // Marge interne droite
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text("IMC : ${record.imc.toStringAsFixed(1)}"),
                        subtitle: Text(
                          "${record.poids}kg pour ${record.taille}m - ${record.qualificatif}",
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
