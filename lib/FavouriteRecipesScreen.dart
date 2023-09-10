import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'Model/recipeModel.dart';
import 'RecipeView.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  @override
  _FavoriteRecipesScreenState createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _utentiCollection = FirebaseFirestore.instance.collection('Flutter');
  bool isLoading = false;
  late String data = '';
  late String email='';
  User? _user;
  List<RecipeModel> recipeData = <RecipeModel>[];


  Future<void> getFavoriteRecipes() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Flutter')
          .doc(email)
          .collection('Ricette preferite FL')
          .get();

      for (final DocumentSnapshot document in querySnapshot.docs) {
        final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Ora puoi accedere ai dati interni del documento
        final String recipeUri = data['recipeUri'];
print(recipeUri);

        /*final String id = extractIdFromUri(recipeUri);
        print(id);*/

        // Ora puoi accedere ai dati interni del documento
          getRecipe(recipeUri) ;
      }
    } catch (error) {
      print('Errore durante l\'accesso ai dati: $error');
      }
      }

  String extractSubstringAfterWord(String url, String word) {
    final index = url.indexOf(word);
    if (index == -1) {
      // La parola non è stata trovata nell'URL
      return '';
    }

    // Estrai la sottostringa che segue la parola
    final startIndex = index + word.length;
    final extractedSubstring = url.substring(startIndex);

    return extractedSubstring;
  }

  extractIdFromUri(uri) {
    String id = uri.split('#recipe_').pop();
    return id;
  }

  Future<List<DocumentSnapshot>> getFavoriteRecipesss() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Flutter')
        .doc(email)
        .collection('Ricette preferite FL')
        .get();

    // Restituisce una lista di documenti che corrispondono alla query
    return querySnapshot.docs;
  }

  getRecipe(String uri) async { //ricerca by uri (splittato per ricercare id univoco)

    final wordToFind = '#recipe_';

    final id = extractSubstringAfterWord(uri, wordToFind);

    print(id);

    final stringextracted = "http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_";

    String url =
        //"https://api.edamam.com/search?r=$uri&app_id=78cafba0&app_key=00863f5f7cb2ac7a14ce8823fc156279";
    "https://api.edamam.com/api/recipes/v2/by-uri?type=public&uri=$stringextracted$id&app_id=78cafba0&app_key=00863f5f7cb2ac7a14ce8823fc156279";
    print(url);
    Response response = await get(Uri.parse(url));
        print((Uri.parse(url)));

    /*final appId = '78cafba0'; // Sostituisci con il tuo ID app Edamam
    final appKey = '00863f5f7cb2ac7a14ce8823fc156279'; // Sostituisci con la tua chiave app Edamam
    final apiUrl = 'https://api.edamam.com/api/recipes/v2/$uri'; // Componi l'URL con l'URI della ricetta

    final response = await get(
      Uri.parse('$apiUrl?app_id=$appId&app_key=$appKey'),
    );*/

    Map data = jsonDecode(response.body);
    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = new RecipeModel();
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeData.add(recipeModel);
        if (recipeData.isEmpty) {
          return Center(
            child: Text('You\'ve a really hard heart... Poor chefs'),
          );
        }
        setState(() {
          isLoading = false;
        });
        log(recipeData.toString());
      });
    });

    recipeData.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
        email = providerProfile.email!;               //prendo email utente
      }
    }

    getFavoriteRecipes();

    var now=DateTime.now();
    data= '${now.day}-${now.month}-${now.year}';
    super.initState();



/*    favs.forEach((Recipe) {
      getRecipe(Recipe.appuri);
    });*/

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
        title: Text('Your favs here'),
      ),

      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff071938), Color(0xff213A50)]),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: isLoading ? CircularProgressIndicator() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipeData[index].appurl)));
                            },
                            child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        recipeData[index].appimgUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      )),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.black26),
                                          child: Text(
                                            recipeData[index].applabel,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ))),
                                  Positioned(
                                    right: 0,
                                    height: 40,
                                    width: 80,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10)
                                            )
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.local_fire_department, size: 15,),
                                              Text(recipeData[index].appcalories.toString().substring(0, 6)),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    left: 0,
                                    height: 50,
                                    width: 60,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.cyanAccent,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10)
                                            )
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: FutureBuilder<bool>(
                                                  future: isRecipeInFirestore(recipeUri: recipeData[index].appuri), // Supponi di avere l'ID della ricetta
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      // In attesa del risultato
                                                      return CircularProgressIndicator(); // o un'icona di caricamento
                                                    } else if (snapshot.hasError) {
                                                      // Errore nella query
                                                      return Icon(Icons.error); // o un'icona di errore
                                                    } else {
                                                      // Verifica se la ricetta è presente in Firestore
                                                      final bool isRecipePresent = snapshot.data ?? false;

                                                      // Restituisci l'icona corrispondente
                                                      return Icon(
                                                        isRecipePresent ? Icons.favorite : Icons.favorite_border,
                                                        color: isRecipePresent ? Colors.red : Colors.blue, // Opzionale: cambia il colore
                                                      );
                                                    }
                                                  },
                                                ), onPressed: ()  async {

                                                // ID della ricetta da rimuovere
                                                String recipeUri = recipeData[index].appuri;

                                                // Riferimento al documento dell'utente nella collezione
                                                DocumentReference userDocRef = FirebaseFirestore.instance
                                                    .collection('Flutter')
                                                    .doc(email);

                                                // Riferimento alla specifica ricetta della collezione delle ricette preferite dell'utente
                                                CollectionReference favoriteRecipesCollectionRef = userDocRef.collection('Ricette preferite FL');

                                                // Esegui una query per cercare la ricetta specifica tra i preferiti dell'utente
                                                QuerySnapshot querySnapshot =  await favoriteRecipesCollectionRef
                                                    .where('recipeUri', isEqualTo: recipeUri)
                                                    .get() as QuerySnapshot<Object?>;

                                                if (querySnapshot.docs.isNotEmpty) {
                                                  // La ricetta è presente tra i preferiti dell'utente

                                                  // Ottieni il riferimento al documento della ricetta da rimuovere
                                                  DocumentReference recipeToRemoveRef = querySnapshot.docs[0].reference;

                                                  // Esegui la rimozione della ricetta dalla collezione dei preferiti
                                                  recipeToRemoveRef.delete().then((value) {

                                                    setState(() {
                                                      recipeData[index].favoriteIcon = Icons.favorite_border;
                                                      recipeData[index].isFavourite = !recipeData[index].isFavourite; // Cambia l'icona a "non preferito"
                                                    });
                                                    Fluttertoast.showToast(
                                                      msg: 'Recipe deleted from favourites!',
                                                      toastLength: Toast
                                                          .LENGTH_SHORT,
                                                      // Puoi cambiare la durata del toast
                                                      gravity: ToastGravity
                                                          .BOTTOM,
                                                      // Posizione del toast
                                                      timeInSecForIosWeb: 1,
                                                      // Durata del toast per iOS/Web
                                                      backgroundColor: Colors
                                                          .blue,
                                                      // Colore di sfondo del toast
                                                      textColor: Colors
                                                          .white, // Colore del testo del toast
                                                    );
                                                  }).catchError((error) {
                                                    // Gestisci eventuali errori durante l'aggiunta
                                                    Fluttertoast.showToast(
                                                      msg: 'Error during the deletion: $error',
                                                      toastLength: Toast
                                                          .LENGTH_SHORT,
                                                      // Puoi cambiare la durata del toast
                                                      gravity: ToastGravity
                                                          .BOTTOM,
                                                      // Posizione del toast
                                                      timeInSecForIosWeb: 1,
                                                      // Durata del toast per iOS/Web
                                                      backgroundColor: Colors
                                                          .black,
                                                      // Colore di sfondo del toast
                                                      textColor: Colors
                                                          .white, // Colore del testo del toast
                                                    );
                                                  });
                                                }else {
                                                  // Aggiunge la ricetta preferita alla collezione "favoriteRecipes" di Firestore
                                                  FirebaseFirestore.instance
                                                      .collection('Flutter')
                                                      .doc(email) // Usa l'ID dell'utente come ID del documento
                                                      .collection('Ricette preferite FL')
                                                      .doc(recipeData[index].applabel)
                                                      .set({'recipeUri': recipeData[index].appuri, 'isFavourite': true,
                                                  }).then((value) {
                                                    setState(() {
                                                      recipeData[index].favoriteIcon = Icons.favorite;
                                                      recipeData[index].isFavourite = !recipeData[index].isFavourite; // Cambia l'icona a "non preferito"
                                                    });
                                                    Fluttertoast.showToast(
                                                      msg: 'Recipe added to favourites!',
                                                      toastLength: Toast
                                                          .LENGTH_SHORT,
                                                      // Puoi cambiare la durata del toast
                                                      gravity: ToastGravity
                                                          .BOTTOM,
                                                      // Posizione del toast
                                                      timeInSecForIosWeb: 1,
                                                      // Durata del toast per iOS/Web
                                                      backgroundColor: Colors
                                                          .red,
                                                      // Colore di sfondo del toast
                                                      textColor: Colors
                                                          .white, // Colore del testo del toast
                                                    );
                                                  }).catchError((error) {
                                                    // Gestisci eventuali errori durante l'aggiunta
                                                    Fluttertoast.showToast(
                                                      msg: 'Error during the adding: $error',
                                                      toastLength: Toast
                                                          .LENGTH_SHORT,
                                                      // Puoi cambiare la durata del toast
                                                      gravity: ToastGravity
                                                          .BOTTOM,
                                                      // Posizione del toast
                                                      timeInSecForIosWeb: 1,
                                                      // Durata del toast per iOS/Web
                                                      backgroundColor: Colors
                                                          .black,
                                                      // Colore di sfondo del toast
                                                      textColor: Colors
                                                          .white, // Colore del testo del toast
                                                    );
                                                  });
                                                }
                                              },
                                              )
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ],
            ),
          ),

        ],
      ),
    );



  }

  Future<bool> isRecipeInFirestore({required String recipeUri}) async {
    // Esegui una query sulla collezione delle ricette con il campo ID della ricetta
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Flutter')
        .doc(email)
        .collection('Ricette preferite FL')
        .where('recipeUri', isEqualTo: recipeUri)
        .get();

    // Verifica se ci sono documenti corrispondenti alla query
    return querySnapshot.docs.isNotEmpty;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> allFavoriteRecipes() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Flutter')
        .doc(email)
        .collection('Ricette preferite FL')
        .get();

    // Restituisce una lista di documenti che corrispondono alla query
    return querySnapshot.docs;
  }
}
