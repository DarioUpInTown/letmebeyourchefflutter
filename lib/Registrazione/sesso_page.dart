import 'package:LetMeBeYourChefFlutter/Registrazione/eta_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class SessoPage extends StatefulWidget {
  final Utente utente;
  const SessoPage({super.key, required this.utente});

  @override
  State<SessoPage> createState() => SessoPageState();
}

class SessoPageState extends State<SessoPage> {
  late String genere='';
  bool checked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
        child: ListView(
          children: <Widget>[
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
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
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
              child: Text('Wich is your gender?',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            )),
            ListTile(
              title: const Text('Man'),
              leading: Radio(
                value: 'Woman',
                groupValue: genere,
                onChanged: (value)  {
                  setState(()  {
                    genere = value!;
                    checked=true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Woman'),
              leading: Radio(
                value: 'Woman',
                groupValue: genere,
                onChanged: (value) {
                  setState(() {
                    genere = value!;
                    checked=true;
                  });
                },
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
                    if(checked!= true){                   //Validazione form
                      const snackBar = SnackBar(
                        content: Text("Select an option"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      widget.utente.sesso=genere;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EtaPage(utente: widget.utente,),));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}