import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  @override
  _FavoriteRecipesScreenState createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _utentiCollection = FirebaseFirestore.instance.collection('Utente');
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final user = _auth.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Le Mie Ricette Preferite'),
      ),
      body: _user == null
          ? Center(
        child: Text('Effettua l\'accesso per visualizzare le tue ricette preferite.'),
      )
          : StreamBuilder<QuerySnapshot>(
        stream: _utentiCollection
            .doc(_user!.email)
            .collection('Ricette preferite FL')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(
              child: Text('Nessuna ricetta preferita trovata.'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final recipeData = documents[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(recipeData['recipeUri']),
                //subtitle: Text(recipeData['recipeUri']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Rimuovi la ricetta preferita
                    _utentiCollection
                        .doc(_user!.email)
                        .collection('Ricette preferite FL')
                        .doc(documents[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
