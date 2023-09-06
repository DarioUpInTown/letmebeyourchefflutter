class Utente{           //Model Utente
  String email;
  String nome;
  String cognome;
  String stile;
  String sesso;
  int eta;


  Utente({
    required this.email,
    required this.nome,
    required this.cognome,
    required this.stile,
    required this.sesso,
    required this.eta,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'stile': stile,
      'sesso': sesso,
      'eta': eta,
    };
  }

  static Utente fromMap(Map<String, Object?> json) => Utente(
    email: json['email'] as String,
    nome: json['nome'] as String,
    cognome: json['cognome'] as String,
    stile: json['stile'] as String,
    sesso: json['sesso'] as String,
    eta: json['eta'] as int,
  );
}