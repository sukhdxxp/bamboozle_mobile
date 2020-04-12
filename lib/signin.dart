import 'package:bamboozle_flutter/categoryPage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String login = """
  mutation login(\$username: String!, \$password: String!) {
    login( username: \$username, password: \$password)  
  }
""";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("LOGIN"),
            TextField(
              controller: nameController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            Mutation(
                options: MutationOptions(
                  documentNode: gql(
                      login), // this is the mutation string you just created
                  // you can update the cache based on results
                  update: (Cache cache, QueryResult result) {
                    return cache;
                  },
                  onError: (error) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                    print(error);
                  },
                  // or do something with the result.data on completion
                  onCompleted: (dynamic resultData) async {
                    final storage = new FlutterSecureStorage();
                    await storage.write(key: "jwt", value: resultData["login"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult result,
                ) {
                  return FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      var username = nameController.text;
                      var password = passwordController.text;
                      runMutation({'username': username, 'password': password});
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  );
                }),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                /*...*/
              },
              child: Text(
                "Login with Google",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                /*...*/
              },
              child: Text(
                "Login with Facebook",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
