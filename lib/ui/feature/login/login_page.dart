import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:registro_elettronico/data/db/dao/profile_dao.dart';
import 'package:registro_elettronico/data/db/moor_database.dart';
import 'package:registro_elettronico/data/network/service/api/chopper_api_services.dart';
import 'package:registro_elettronico/data/network/service/chopper_service.dart';
import 'package:registro_elettronico/data/network/service/retrofit/app_api.service.dart';
import 'package:registro_elettronico/data/network/service/retrofit/entities/login_request.dart';
import 'package:registro_elettronico/data/network/service/retrofit/rest_client.dart';
import 'package:registro_elettronico/ui/bloc/login/bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const double LEFT_LOGIN_PADDING = 80.0;
  static const double TOP_FIELDS_PADDING = 32.0;

  String _errorMessage = null;

  @override
  Widget build(BuildContext context) {
    //! remove passswords
    final String _myUsername = "S6102171X";
    final String _myPassword = "Tf5F7Qd8WxAR23Bh";
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(_buildLoadingSnackBar());
          }

          if (state is LoginWrongCredentials) {
            // TODO: add if password are wrong
          }
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(LEFT_LOGIN_PADDING, 0, 0, 0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Welcome, login with Classeviva
                  _buildWelcomeText("Welcome, "),
                  _buildLoginMessageText("Classeviva"),
                  _buildLoginForm(),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginButtonPressed(
                                  username: _myUsername,
                                  password: _myPassword));
                        },
                      )),
                  RaisedButton(
                    child: Text('Service request'),
                    onPressed: () async {
                      final rep = LoginApiService.create();
                      final loginData = {
                        "ident": "$_myUsername",
                        "pass": "$_myPassword",
                        "uid": "$_myUsername"
                      };

                      final dio = Dio();
                      dio.options.headers["Content-Type"] = "application/json";
                      dio.options.headers["User-Agent"] = "zorro/1.0";
                      dio.options.headers["Z-Dev-Apikey"] = "+zorro+";
                      final client = RestClient(dio);
                      final loginRequest = LoginRequest(
                          ident: "S6102171X",
                          pass: "Tf5F7Qd8WxAR23Bh",
                          uid: "S6102171X");
                      final res =
                          await client.loginUser(json.encode(loginData));

                      print(res.firstName);
                      //final body = json.encode(loginData);
                      //print(body);
                      //final res = await rep.postLogin(loginData);
                      //print(res.bodyString);
                      //print(res.statusCode);
                      ///print(res.headers);
                    },
                  )
                  //_buildProfilesList(context)
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  SnackBar _buildLoadingSnackBar() {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Logging In...'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Container _buildWelcomeText(String welcomeMessage) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Welcome,",
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }

  Row _buildLoginMessageText(String registerName) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            "Login with ",
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        Container(
          child: Text("Classeviva",
              style: TextStyle(color: Theme.of(context).accentColor)),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: EdgeInsets.only(top: TOP_FIELDS_PADDING),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsetsGeometry.lerp(
                      const EdgeInsetsDirectional.only(end: 6.0),
                      EdgeInsets.symmetric(vertical: 5),
                      2.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  errorText: _errorMessage,
                  hintText: 'Password',
                  contentPadding: EdgeInsetsGeometry.lerp(
                      const EdgeInsetsDirectional.only(end: 6.0),
                      EdgeInsets.symmetric(vertical: 5),
                      2.0)),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Profile>> _buildProfilesList(BuildContext context) {
    final ProfileDao profileDao =
        ProfileDao(Injector.appInstance.getDependency());
    return StreamBuilder(
      stream: profileDao.watchAllprofiles(),
      builder: (context, AsyncSnapshot<List<Profile>> snapshot) {
        final profiles = snapshot.data ?? List();
        return ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (_, index) {
            final profile = profiles[index];
            return Text(profile.ident);
          },
        );
      },
    );
  }
}
