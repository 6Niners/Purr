import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  bool password_validated=false;
  TextEditingController _Currentpassword = TextEditingController();
  TextEditingController _Newpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextCurrentPassword=true;
  bool _obscureTextNewPassword=true;
  bool _obscureTextConfirmPassword=true;

  RegistrationController CONT = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wallpaper-cat.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _formKey,
              child: Center(
                child: Card(
                  color: Colors.grey[100],
                  elevation: 30,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                          ),

                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(5),
                                child: TextFormField(
                                  validator: (value) {
                                    if(password_validated){return null;}else{return "wrong password";}
                                  },
                                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: _Currentpassword,
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                      labelText: 'Current Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _obscureTextCurrentPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _obscureTextCurrentPassword = !_obscureTextCurrentPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: _obscureTextCurrentPassword,
                                ),
                              ),

                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: TextFormField(
                              validator: (input) {
                                if (input.length < 6) {
                                  return 'Your password should be at least 6 characters';
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _Newpassword,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureTextNewPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _obscureTextNewPassword = !_obscureTextNewPassword;
                                    });
                                  },
                                ),),
                              obscureText: _obscureTextNewPassword,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: TextFormField(
                              validator: (input) {
                                if (input != _Newpassword.text) {
                                  return "These passwords don't match";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(fontSize: 20),
                              decoration:
                                  InputDecoration(labelText: 'Confirm Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _obscureTextConfirmPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                                        });
                                      },
                                    ),),
                              obscureText: _obscureTextConfirmPassword,
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
                                    password_validated=await CONT.validatePassword(_Currentpassword.text);
                                    setState(() {});
                                    if (_formKey.currentState.validate()&&password_validated) {
                                      await CONT.updatePassword(_Newpassword.text);
                                    }
                                  },
                                  child: Text('Sign Up'),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ))),
    );
  }
}
