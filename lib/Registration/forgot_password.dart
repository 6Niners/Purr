import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';

class ForgotpasswordPage extends StatefulWidget {
  ForgotpasswordPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ForgotpasswordPageState createState() => ForgotpasswordPageState();
}

class ForgotpasswordPageState extends State<ForgotpasswordPage> {

  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegistrationController CONT=Get.find();
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
                    color: Colors.grey[400],
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
                                child: Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: TextFormField(
                                validator: (input) {
                                  if (!EmailValidator.validate(input)) {
                                    return 'Please type a valid Email';
                                  }
                                  return null;
                                },
                                controller: _email,
                                style: TextStyle(fontSize: 20),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    labelText: 'Email'
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
                                      await CONT.forgotpassword(_email.text);
                                  }
                                  },
                                  child: Text('Send Mail',style: TextStyle(fontSize: 20,))
                                ),
                              ),

                            ],
                          ),

                        ]
                    ),
                  ),
                )
            ))
    );
  }





}