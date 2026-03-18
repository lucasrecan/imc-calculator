class IMCRecord {
  final double poids;
  final double taille;
  final double imc;

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
  String toString() {
    return 'Record(poids: $poids, taille: $taille), imc: $imc';
  }

  IMCRecord({required this.poids, required this.taille, required this.imc});
}
