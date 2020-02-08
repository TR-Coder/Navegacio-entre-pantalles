import 'package:flutter/material.dart';

// --------------------
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;
    switch (settings.name) {
      case SecondScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => SecondScreen(title: args['title'], message: args['message']),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

// --------------------

void main() => runApp(MyApp());

// --------------------

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/one',
      routes: <String, WidgetBuilder>{
        '/one': (context) => FirstScreen(),
        '/two': (context) => SecondScreen(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// CLASS FirstSreen

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String text = 'Este text es pot editar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Primera pantalla'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Edita'),
                onPressed: () {
                  //Map<String, dynamic> args = {'title': 'aaaa', 'message': 'bbbb'};
                  Navigator.pushNamed(context, SecondScreen.routeName,
                      //arguments: args,
                      arguments: {'title': 'aaaa', 'message': 'bbbb'}).then((value) {
                    if (value != null) {
                      setState(() {
                        text = value;
                      });
                    }
                  });
/*                   Navigator.pushNamed(context, '/two', arguments: text).then((result) {
                    if (result != null) {
                      setState(() {
                        text = result;
                      });
                    }
                  }); */
                },
              )
            ],
          ),
        ));
  }
}

// CLASS SecondSreen

class SecondScreen extends StatefulWidget {
  static const routeName = '/SecondScreen';
  final String title, message;

  const SecondScreen({Key key, this.title, this.message}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.title + " " + widget.message;
    return Scaffold(
      appBar: AppBar(
        title: Text('Segona pantalla'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(controller: _controller),
          RaisedButton(
            child: Text('Edita'),
            onPressed: () {
              Navigator.of(context).pop(_controller.text);
            },
          )
        ],
      )),
    );
  }
}
