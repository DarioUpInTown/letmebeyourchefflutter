import 'package:LetMeBeYourChefFlutter/Registrazione/register_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class EtaPage extends StatefulWidget {
  final Utente utente;
  const EtaPage({super.key, required this.utente});

  @override
  State<EtaPage> createState() => EtaPageState();
}

class EtaPageState extends State<EtaPage> {
  final formKey= GlobalKey<FormState>();
  final etaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 57, 15, 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
              ],
            ),

            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                child: SizedBox(
                    width: 250,
                    height:250,
                    child: Image(image: AssetImage('assets/images/logo_no_background.png'))),
              ),
            ),
            const Center(child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text('How old are you?',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            )),
            Form(
              key: formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: TextFormField(
                          controller: etaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 2, color: Colors.orange),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            labelText: 'Age: 16-113 years old',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 120, 50, 8),
                        child: SizedBox(
                          width:200,
                          height:60,
                          child: ElevatedButton(
                            style: ButtonStyle(

                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    )
                                )
                            ),
                            child: const Text("NEXT",style: TextStyle(
                              fontSize: 24,
                            ),),
                            onPressed: () {
                              if(etaController.text==""){
                                const snackBar = SnackBar(
                                  content: Text("Insert an age between 16 and 113 years"),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{
                                int eta= int.parse(etaController.text);                             //Validazione form
                                if(eta<=113 && eta>=16){
                                  widget.utente.eta=eta;
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RegisterPage(utente: widget.utente),));

                                }else{
                                  const snackBar = SnackBar(
                                    content: Text("Insert an age between 16 and 113 years"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}