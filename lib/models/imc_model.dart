import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_imc_rcl4463a/models/imc_record.dart';

class IMCModel extends ChangeNotifier {
  final List<IMCRecord> _historique = [];

  List<IMCRecord> get historique => _historique;

  void ajouterIMC({
    required double poids,
    required double taille,
    required double imc,
  }) {
    _historique.add(IMCRecord(poids: poids, taille: taille, imc: imc));
    notifyListeners();
  }

  void supprimerIMC(int index) {
    _historique.removeAt(index);
    notifyListeners();
  }
}