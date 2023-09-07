class Utente{           //Model Utente
  String email;
  String nome;
  String cognome;
  String intolleranze;
  String sesso;
  int eta;


  Utente({
    required this.email,
    required this.nome,
    required this.cognome,
    required this.intolleranze,
    required this.sesso,
    required this.eta,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'intolleranze': intolleranze,
      'sesso': sesso,
      'eta': eta,
    };
  }

  static Utente fromMap(Map<String, Object?> json) => Utente(
    email: json['email'] as String,
    nome: json['nome'] as String,
    cognome: json['cognome'] as String,
    intolleranze: json['intolleranze'].toString() as String,
    sesso: json['sesso'] as String,
    eta: json['eta'] as int,
  );
}