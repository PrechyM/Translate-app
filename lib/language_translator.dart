import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslatorPage extends StatefulWidget {
  const LanguageTranslatorPage({super.key});

  @override
  State<LanguageTranslatorPage> createState() => _LanguageTranslatorPageState();
}

class _LanguageTranslatorPageState extends State<LanguageTranslatorPage> {
  var languages = ['Romanian','English','French'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = '';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input,from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src=='--' || dest=='--'){
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode(String language){
    if(language=="Romanian") {
      return "ro";
    }else if(language=="English"){
      return "en";
    }else if(language=="French"){
      return "fr";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: Text("Language Translator"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Center(child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    originLanguage,style: TextStyle(color: Colors.blue),
                  ),
                dropdownColor: Colors.green,
                icon: Icon(Icons.keyboard_arrow_down),
                items: languages.map((String dropDownStringItem){
                  return DropdownMenuItem(child: Text(dropDownStringItem),
                    value: dropDownStringItem,);
                }).toList(),
                onChanged: (String? value){
                  setState(() {
                    originLanguage = value!;
                  });
                },
                ),
                SizedBox(width: 40,),
                Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                SizedBox(width: 40,),
                DropdownButton(focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    destinationLanguage,style: TextStyle(color: Colors.blue),
                  ),
                  dropdownColor: Colors.green,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: languages.map((String dropDownStringItem){
                    return DropdownMenuItem(child: Text(dropDownStringItem),
                      value: dropDownStringItem,);
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      destinationLanguage = value!;
                    });
                  },
                )
                ],
            ),
            SizedBox(height: 40,),
            Padding(padding: EdgeInsets.all(8),
            child: TextFormField(
              cursorColor: Colors.red,
              autofocus: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Please enter your text...',
                labelStyle: TextStyle(fontSize: 15,color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1
                  ),
                ),
                errorStyle: TextStyle(color: Colors.yellow,fontSize: 15),
              ),
              controller: languageController,
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Please enter text to translate';
                }
                  return null;
              },
            ),),
            Padding(padding: EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xff10223d)),
              onPressed: (){
                translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
              },
              child: Text("Translate")),
            ),
            SizedBox(height: 20,),
            Text(
              "\n$output",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}