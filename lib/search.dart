import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'RecipeView.dart';
import 'Model/recipeModel.dart';
import 'package:http/http.dart';


class Search extends StatefulWidget {
  String query;
  Search(this.query);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late String data = '';
  late String email='';

  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];
  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=78cafba0&app_key=00863f5f7cb2ac7a14ce8823fc156279";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = new RecipeModel();
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);
        setState(() {
          isLoading = false;
        });
        log(recipeList.toString());
      });
    });


    recipeList.forEach((Recipe) {
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
    var now=DateTime.now();
    data= '${now.day}-${now.month}-${now.year}';    super.initState();
    getRecipes(widget.query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0xff071938)]),
            ),
          ),

          /*
      * InWell - Tap,DoubleTaP,etc.
      * Gesture Detector
      *
      * Hover - Color
      * Tap - Splash
      *
      * Getsure -
      * Swipe,'
      *
      * Card - elevation background color,radius child
      *
      * ClipRRect - Frame - Photo Rectangle
      *
      * ClipPath - Custom CLips
      *
      * positioned  - Stack - topleft , top,down,left - 2.2
      *
      * */
          SingleChildScrollView(
            child: Column(
              children: [
                //Search Bar
                SafeArea(
                  child: Container(
                    //Search Wala Container

                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's Cook Something!"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                    child: isLoading ? CircularProgressIndicator() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipeList[index].appurl)));
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
                                        recipeList[index].appimgUrl,
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
                                            recipeList[index].applabel,
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
                                              Text(recipeList[index].appcalories.toString().substring(0, 6)),
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
                                                  future: isRecipeInFirestore(recipeUri: recipeList[index].appuri), // Supponi di avere l'ID della ricetta
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
                                                String recipeUri = recipeList[index].appuri;

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
                                                      recipeList[index].favoriteIcon = Icons.favorite_border;
                                                      recipeList[index].isFavourite = !recipeList[index].isFavourite; // Cambia l'icona a "non preferito"
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
                                                      .doc(recipeList[index].applabel)
                                                      .set({'recipeUri': recipeList[index].appuri, 'isFavourite': true,
                                                  }).then((value) {
                                                    setState(() {
                                                      recipeList[index].favoriteIcon = Icons.favorite;
                                                      recipeList[index].isFavourite = !recipeList[index].isFavourite; // Cambia l'icona a "non preferito"
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
}

