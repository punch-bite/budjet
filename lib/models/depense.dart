
class Depense {
  final String id;
  final String name;
  final String montant;
  // ignore: non_constant_identifier_names
  final DateTime created_at;

  Depense({
    required this.id,
    required this.name,
    required this.montant,
    // ignore: non_constant_identifier_names
    required this.created_at,
  });

  Depense copyWith({
    String? id,
    String? name,
    String? montant,
    // ignore: non_constant_identifier_names
    DateTime? created_at,
  }) {
    return Depense(
      id: id ?? this.id,
      name: name ?? this.name,
      montant: montant ?? this.montant,
      created_at: created_at ?? this.created_at,
    );
  }
}
