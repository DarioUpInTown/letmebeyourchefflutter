import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:letmebeyourchefflutter/homepage.dart';
import 'package:letmebeyourchefflutter/model.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  //aggiungere chiamata http a edamam

  getRecipe(String query) async {
    String url="https://api.edamam.com/search?q=$query&app_id=d6514d39&app_key=40431e11d35ff909597ab69b1b0e04f9";
    Response response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    log(data.toString());

    data ["hits"].forEach((element){
        RecipeModel recipeModel = new RecipeModel();
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);
        log(recipeList.toString());
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Ladoo");
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children:[
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff213A50),
                    Color(0xff071938)
                  ]
                )
              ),
            ),



          /*  SingleChildScrollView(
               child: Column(
                 children: [
                 ],
               ),
            ),
*/
          ),

          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What do you want cook today?", style: TextStyle(fontSize: 40, color: Colors.white)),
                SizedBox(height: 10,),
                Text("Let's cook something!",style: TextStyle(fontSize: 20,color: Colors.white),)
                //GestureDetector(
                //  onTap: {

                //  }),


               ],
            ),
          ),
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipeList.length,
                itemBuilder: (context, index){
              return InkWell(
                onTap: (){},
                child: Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0.0,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius : BorderRadius.circular(10.0),
                        child: Image.network(

                          recipeList[index].appimgUrl,
                        fit : BoxFit.cover,
                        width: double.infinity,
                        height: 200,)
                      ),
                      Positioned(
                        left : 0,
                          right: 0,

                          bottom : 0,
                          child:
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.black26
                              ),
                              child: Text(
                                  recipeList[0].applabel,
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
                        color:Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                        ),
                        ),

                        child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_fire_department, size:13),
                            Text(recipeList[index].appcalories.toString().substring(0,6))
                        ],
                        ),
                      ),
                      ),
                    ),
                          ),
                      );
                    ],
                  )
                ),
              );
            },),
          ),

        ],

      ),

    ),
  },
}
