import 'package:flutter/material.dart';

import 'package:tryme/Globals.dart';

class CompanyInformationView extends StatefulWidget {
  @override
  _CompanyInformationViewState createState() => _CompanyInformationViewState();
}

String modifyPhoneNumber(String phoneNumber) {
  String tmp = phoneNumber;
  phoneNumber =
      tmp.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
  phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
  return (phoneNumber);
}

String modifySiret(String siret) {
  String tmp = siret;
  siret = tmp.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");
  var parts = siret.split(" ");
  siret = parts[0] + ' ' + parts[1] + ' ' + parts[2] + ' ' + parts[3] + parts[4];
  return (siret);
}
class _CompanyInformationViewState extends State<CompanyInformationView> {
  var edit = new List(6);
  double _widthScreen;
  double _heightScreen;
  bool _infoValid;
  final _formKey = GlobalKey<FormState>();

  String buttonText = 'Sauvegarder';
  String tmp;

  @override
  void initState() {
    initBool(edit);
    super.initState();
  }

  void initBool(var list) {
    for (int i = 0; i < 6; i++) {
      list[i] = false;
    }
  }

  Widget _presentation(double widthScreen) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(widthScreen / 20),
          child: CircleAvatar(
            backgroundImage: NetworkImage(company.pathToAvatar),
            radius: widthScreen / 10,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  //get first name here
                  child: Text(
                    company.name,
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  //get last name here
                  child: Text(
                    company.email,
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _companyName(var edit) {
    if (edit[1]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer le nom de votre entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z0-9-]{2,16}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré le nom de votre entreprise";
                          } else if (!_infoValid) {
                            return "Le nom de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[1] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    print(tmp);
                    company.name = tmp;
                    print(company.name);
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                company.name,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[1] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _companyEmail(var edit) {
    if (edit[2]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer l'email de la entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$").hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentrer l\'email de la entreprise";
                          } else if (!_infoValid) {
                            return "L\'email de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[2] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    company.email = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                company.email,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[2] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _companyPhoneNumber(var edit) {
    if (edit[3]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.phoneNumber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer le numéro de téléphone de votre entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          _infoValid = RegExp(r"^[0-9]{10,10}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré le numéro de téléphone de votre entreprise";
                          } else if (!_infoValid) {
                            return "Le numéro de téléphone de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[3] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    tmp = modifyPhoneNumber(tmp);
                    company.phoneNumber = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                company.phoneNumber,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[3] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _companyAddress(var edit) {
    if (edit[4]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.address,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer l'addresse de votre entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          _infoValid =
                              RegExp(r"^[a-zA-Z0-9-', ]{2,100}$").hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré l\'adresse de votre entreprise";
                          } else if (!_infoValid) {
                            return "L\'adresse de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[4] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    company.address = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                company.address,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[4] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _companySiret(var edit) {
    if (edit[5]) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.orange,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Color(0xfff99e38),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: company.siret,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Entrer le SIRET de votre entreprise",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          _infoValid = RegExp(r"^[0-9]{14,14}$")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return "Vous n\'avez pas rentré le SIRET de votre entreprise";
                          } else if (!_infoValid) {
                            return "Le format du SIRET de votre entreprise est incorrect";
                          }
                          tmp = value;
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    edit[5] = false;
                    edit[0] = false;
                    buttonText = 'Sauvegarder';
                    tmp = modifySiret(tmp);
                    company.siret = tmp;
                  }
                });
              },
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                company.siret,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (!edit[0]) {
                    edit[5] = true;
                    edit[0] = true;
                    buttonText = '';
                  }
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }
  

  Widget _myDivider() {
    return Container(
      margin:
          EdgeInsets.only(left: _widthScreen / 10, right: _widthScreen / 10),
      child: Divider(
        height: 1,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    _heightScreen = (_height > _width) ? _height : _width;
    _widthScreen = (_height > _width) ? _width : _height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Informations entreprise'),
        centerTitle: true,
        backgroundColor: Color(0xfff99e38),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _heightScreen * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _presentation(_widthScreen),
              _myDivider(),
              _companyName(edit),
              _myDivider(),
              _companyEmail(edit),
              _myDivider(),
              _companyPhoneNumber(edit),
              _myDivider(),
              _companyAddress(edit),
              _myDivider(),
              _companySiret(edit),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (!edit[0]) {
                      //fonction de sauvegarde en bdd + quitter la View
                      print('Sauvegarder and quit');
                    }
                  });
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Color(0xfff99e38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}