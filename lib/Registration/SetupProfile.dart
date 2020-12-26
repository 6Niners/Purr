import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Services/Database.dart';

class SetupProfilePage extends StatefulWidget {

  @override
  SetupProfilePageState createState() => SetupProfilePageState();
}

class SetupProfilePageState extends State<SetupProfilePage> {


  TextEditingController _petName=TextEditingController();
  TextEditingController _pet=TextEditingController();
  TextEditingController _breed=TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseService CONT=Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wallpaper-cat.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _formKey,
              child: Center(
                child: Card(
                  color: Colors.grey[100],
                  elevation: 30,

                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              child: Text("Setup Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                              validator: (input) {
                                if (input == '') {
                                  return 'Please type a your pet name';
                                }
                                else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _petName,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  labelText: 'Pet Name'
                              )
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                              validator: (input) {
                                if (input == '') {
                                  return 'Please your pet type';
                                }
                                else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _pet,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  labelText: 'Pet'
                              )
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                              validator: (input) {
                                if (input == '') {
                                  return 'Please your pet breed';
                                }
                                else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _breed,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  labelText: 'Breed'
                              )
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              width: 150,
                              height: 70,

                              child: RaisedButton(
                                color: Colors.grey,
                                onPressed: () async {
                                  Get.back();
                                },
                                child: Text('Back'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              width: 150,
                              height: 70,

                              child: RaisedButton(
                                color: Colors.blue,

                                onPressed: () async {
                                  //print("in");
                                  if (_formKey.currentState.validate()) {
                                    await CONT.updateUserData(_petName.text, _pet.text, _breed.text);}
                                },
                                child: Text('Next'),
                              ),
                            )
                          ],
                        ),
                      ]
                  ),
                ),
              )
          )
      ),
    );
  }





}