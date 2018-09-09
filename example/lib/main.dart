import 'package:flutter/material.dart';
import 'package:easy_dialogs/easy_dialogs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Dialogs Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final List<String> _ringTones = [
    'None',
    'Callisto',
    'Ganymede',
    'Luna',
    'Oberon',
    'Phobos',
    'Dione',
    'Jungle Gym',
    'Ukulele',
    'Snowflakes',
  ];

  final List<Color> _colors = [
    Colors.orange,
    Colors.pinkAccent,
    Colors.black,
    Colors.blue,
    Colors.brown,
    Colors.green,
  ];

  String _ringTone = "None";

  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: _openRingtoneDialog,
            title: Text('Ringtone'),
            subtitle: Text(_ringTone),
            leading: Icon(Icons.music_note),
          ),
          ListTile(
              onTap: _openColorDialog,
              title: Text('Color'),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8.0),
                height: 20.0,
                color: _color,
              ),
              leading: Icon(Icons.colorize)),
          ListTile(
              onTap: _openColorDialogWithoutConfirmation,
              title: Text('Color without confirmation'),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8.0),
                height: 20.0,
                color: _color,
              ),
              leading: Icon(Icons.colorize)),
        ],
      ),
    );
  }

  _openRingtoneDialog() {
    showDialog(
        context: context,
        builder: (context) => SingleChoiceConfirmationDialog<String>(
            title: Text('Phone ringtone'),
            initialValue: _ringTone,
            items: _ringTones,
            onSelected: _onSelected,
            onSubmitted: _onSubmitted));
  }

  _openColorDialog() {
    showDialog(
      context: context,
      builder: (context) => SingleChoiceConfirmationDialog<Color>(
            title: Text('Color'),
            initialValue: _color,
            items: _colors,
            contentPadding: EdgeInsets.symmetric(vertical: 16.0),
            divider: Container(
              height: 1.0,
              color: Colors.blue,
            ),
            onSubmitted: (Color color) {
              setState(() => _color = color);
            },
            itemBuilder: (Color color) =>
                Container(height: 100.0, color: color),
          ),
    );
  }

  _openColorDialogWithoutConfirmation() {
    showDialog(
        context: context,
        builder: (context) => SingleChoiceDialog<Color>(
              isDividerEnabled: true,
              title: Text('Pick a color'),
              items: _colors,
              onSelected: (Color color) {
                setState(() => _color = color);
              },
              itemBuilder: (Color color) =>
                  Container(height: 100.0, color: color),
            ));
  }

  void _onSelected(String value) {
    print('Selected $value');
    setState(() {
      _ringTone = value;
    });
  }

  void _onSubmitted(String value) {
    print('Submitted $value');
    setState(() {
      _ringTone = value;
    });
  }
}
