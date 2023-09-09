import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeModel
{
  late String appuri;
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;
  late IconData favoriteIcon = Icons.favorite_border;
  late bool isFavourite = false;

  RecipeModel({this.appuri = "URI", this.applabel = "LABEL" , this.appcalories= 0.000 , this.appimgUrl= "IMAGE", this.appurl="URL",});
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
        appuri: recipe["uri"],
        applabel: recipe["label"],
        appcalories: recipe["calories"],
        appimgUrl: recipe["image"],
        appurl: recipe["url"],
    );
  }
}