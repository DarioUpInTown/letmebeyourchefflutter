import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class ProfiloPage extends StatefulWidget {
  const ProfiloPage({Key? key}) : super(key: key);

  @override
  State<ProfiloPage> createState() => ProfiloPageState();
}

class ProfiloPageState extends State<ProfiloPage> {
  final formKey= GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final cognomeController = TextEditingController();
  final emailController = TextEditingController();
  final etaController = TextEditingController();        //controller form
  late String email='';
  late String nome='';
  late String cognome='';
  late String data='';
  late String stile='';
  late String genere='';
  late int eta=0;
  late Utente? utente=null;
  Utente utenteMod= Utente(email: '', nome: '', cognome: '', stile: '', sesso: '', eta: 0);
  final List<String> genderItems = [
    'Man',               //lista dropdown button sesso
    'Woman',
  ];
  final List<String> stileItems = [
    'Sedentario',
    'Poco Attivo',
    'Attivo',             //lista dropdown button stile di vita
    'Molto Attivo',
  ];


  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
        for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
          emailController.text= providerProfile.email!;
          email = providerProfile.email!;                 //prendo la mail dell'utente
          utenteMod.email=providerProfile.email!;
        }
    }

    return super.initState();
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Profile'),
      ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Expanded(
              child: FutureBuilder<Utente?>(
                future: readUtente(),
                builder: (context, snapshot) {
                if(snapshot.hasData){
                utente=snapshot.data!;
                nomeController.text = utente!.nome;
                cognomeController.text = utente!.cognome;
                etaController.text = utente!.eta.toString();          //inizializzo le form con i dati dell'utente
                stile = utente!.stile;
                genere = utente!.sesso;
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: TextFormField(
                            controller: nomeController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              labelText: 'First name',
                                labelStyle: (const TextStyle(
                                  color: Colors.green,))
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: TextFormField(
                            controller: cognomeController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              labelText: 'Last name',
                                labelStyle: (const TextStyle(
                                  color: Colors.green,))
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                enabled: false,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                labelText: 'Email',
                                labelStyle: (const TextStyle(
                                  color: Colors.grey,))
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: DropdownButtonFormField(
                              value: genere,
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  labelText: 'Gender',
                                  labelStyle: (const TextStyle(
                                    color: Colors.green,))
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              hint: const Text(
                                'Gender',
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,

                              //buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //dropdownDecoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              //),
                              items: genderItems
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (value) {
                                genere = value!;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: DropdownButtonFormField(
                              value: stile,
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  labelText: 'Stile di Vita',
                                  labelStyle: (const TextStyle(
                                    color: Colors.green,))
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              hint: const Text(
                                'Stile di Vita',
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,

                              items: stileItems
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (value) {
                                stile = value!;
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: TextFormField(
                                  controller: etaController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    labelText: 'Età',
                                  ),
                                ),
                              ),
                            ),
                            /*Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: TextFormField(
                                  controller: pesoController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    labelText: 'Peso',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                child: TextFormField(
                                  controller: altezzaController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    labelText: 'Altezza',
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: SizedBox(
                            height:60,
                            child: ElevatedButton(
                              style: ButtonStyle(

                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      )
                                  )
                              ),
                              child: const Text("SAVE ALL",style: TextStyle(
                                fontSize: 24,
                              ),),
                              onPressed: () {
                                if(nomeController.text==''){
                                  const snackBar = SnackBar(
                                    content: Text("Insert a first name"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else{
                                  if(cognomeController.text==''){
                                    const snackBar = SnackBar(            //Validazione form
                                      content: Text("Insert a last name"),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }else/*{
                                    if(altezzaController.text=='' || (int.parse(altezzaController.text)>200 || int.parse(altezzaController.text)<130)){
                                      const snackBar = SnackBar(
                                        content: Text("Inserisci un'altezza tra 130 e 200 cm"),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }else{
                                      if(pesoController.text=="" || (double.parse(pesoController.text)>200 || double.parse(pesoController.text)<40)){
                                        const snackBar = SnackBar(
                                          content: Text("Inserisci un peso tra 40 e 200 kg"),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else*/{
                                        if(etaController.text=="" || (int.parse(etaController.text)>90 || int.parse(etaController.text)<16)){
                                          const snackBar = SnackBar(
                                            content: Text("Insert an age between 16 and 90 years"),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }else{
                                          utenteMod.nome = nomeController.text;
                                          utenteMod.cognome= cognomeController.text;
                                          utenteMod.eta= int.parse(etaController.text);
                                          //utenteMod.peso= double.parse(pesoController.text);        //se valide ricalcolo kcal e nutrienti in base ai dati forniti
                                          //utenteMod.altezza= int.parse(altezzaController.text);
                                          utenteMod.sesso=genere;
                                          utenteMod.stile=stile;
                                          updateUtente(utenteMod);
                                          const snackBar = SnackBar(                    //modifico utente
                                            content: Text('User data updated'),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              snackBar);
                                        }
                                      }
                                    }



                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                  }else{
                  return Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,        //schermata caricamento mentre vengono prelevati i dati
                    children: const [
                      Icon(Icons.loop),
                      Text('Loading'),
                    ],
                  ));
                }
                }
              )

              ),
            ),
        ],
      ),
    );
  }
   Future<Utente?> readUtente() async {                                       //leggo i dati dell'utente
     final docUtente = FirebaseFirestore.instance.collection('UtenteFL').doc(email);
     final snapshot= await docUtente.get();
     if(snapshot.exists){
       return Utente.fromMap(snapshot.data()!);
     }
     return null;
  }                                                                     //modifico i dati dell'utente
  Future updateUtente(Utente utente) async {
    final docUtente = FirebaseFirestore.instance.collection('UtenteFL').doc(utente.email);
    docUtente.update({
      'nome': utente.nome,
      'cognome': utente.cognome,
      'stile': utente.stile,
      'sesso': utente.sesso,
      'eta': utente.eta,
    });
  }
}

