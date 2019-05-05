import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/application.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _openNotification = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(primaryColor: Colors.pink, iconTheme: IconThemeData(color: Colors.pink)),
        child: Scaffold(
          appBar: AppBar(
            title: Text('设置'),
          ),
          body: ListView(
            children: <Widget>[
              SwitchListTile(
                  activeColor: Colors.pink,
                  title: Text('是否接收通知'),
                  value: _openNotification,
                  onChanged: (value) {
                    setState(() {
                      this._openNotification = value;
                    });

                    if (value) {
                      Application.jPush.resumePush();
                    } else {
                      Application.jPush.stopPush();
                    }
                  })
            ],
          ),
        ));
  }
}
