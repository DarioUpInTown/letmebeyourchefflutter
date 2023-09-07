import 'package:LetMeBeYourChefFlutter/Registrazione/sesso_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class IntolleranzePage extends StatefulWidget {
  final Utente utente;
  const IntolleranzePage( {super.key, required this.utente,});

  @override
  State<IntolleranzePage> createState() => IntolleranzePageState();
}

class IntolleranzePageState extends State<IntolleranzePage> {
  bool checked= true;
  String intolleranze = "None"; // Set the default

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
              child: Text('Do you have any allergy or food intolerance?',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
            )),
            const Center(child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text('If not, go ahead',style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal), textAlign: TextAlign.start),
            )),
            ListTile(
              title: const Text('None'),
              leading: Radio(
                value: 'None',
                groupValue: intolleranze,
                onChanged: (value)  {
                  setState(()  {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Dairy'),
              leading: Radio(
                value: 'Dairy',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Gluten'),
              leading: Radio(
                value: 'Gluten',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Peanut'),
              leading: Radio(
                value: 'Peanut',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Grain'),
              leading: Radio(
                value: 'Grain',
                groupValue: intolleranze,
                onChanged: (value)  {
                  setState(()  {
                    intolleranze = value!;
                    checked= false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Seafood'),
              leading: Radio(
                value: 'Seafood',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Egg'),
              leading: Radio(
                value: 'Egg',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Sesame'),
              leading: Radio(
                value: 'Sesame',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Shellfish'),
              leading: Radio(
                value: 'Shellfish',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Soy'),
              leading: Radio(
                value: 'Soy',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Sulfite'),
              leading: Radio(
                value: 'Sulfite',
                groupValue: intolleranze,
                onChanged: (value)  {
                  setState(()  {
                    intolleranze = value!;
                    checked= false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Tree nut'),
              leading: Radio(
                value: 'Tree nut',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Wheat'),
              leading: Radio(
                value: 'Wheat',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Other'),
              leading: Radio(
                value: 'Other',
                groupValue: intolleranze,
                onChanged: (value) {
                  setState(() {
                    intolleranze = value!;
                    checked= true;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 8),
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
                  child: const Text("NEXT", style: TextStyle(
                    fontSize: 24,
                  ),),
                  onPressed: () {
                    if(checked!= true){               //Validazione form
                      const snackBar = SnackBar(
                        content: Text("Choose an option"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      widget.utente.intolleranze=intolleranze;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SessoPage(utente: widget.utente,),));
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