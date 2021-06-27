import 'dart:io';

import 'package:flutter/material.dart';

class SettingHomePage extends StatefulWidget {
  Function(int port) _createServerCallback;
  Function(String address, int port) _createClientCallback;
  Function(BuildContext childContext) _goToChatPage;

  SettingHomePage(
      this._createServerCallback,
      this._createClientCallback,
      this._goToChatPage);

  @override
  State<StatefulWidget> createState() {
    return _SettingHomeState();
  }
}

class _SettingHomeState extends State<SettingHomePage> {
  String ipAddress = "";

  var _serverPortController = TextEditingController();
  var _clientAddressController = TextEditingController();
  var _clientPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getIpAddress();
  }

  @override
  void dispoe() {
    super.dispose();
    _serverPortController.dispose();
    _clientAddressController.dispose();
    _clientPortController.dispose();
  }

  void getIpAddress() {
    NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.any)
        .then((List<NetworkInterface> interfaces) => {
      setState(() {
        ipAddress = "";
        interfaces.forEach((interface) {
          ipAddress += "${interface.name}\n";
          interface.addresses.forEach((address) {
            ipAddress += "${address.address}\n";
          });
        });
      })
    });
  }

  Widget getDeviceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "本机 IP 地址",
          style: TextStyle(fontSize: 26),
        ),
        Text(ipAddress)
      ],
    );
  }

  Widget getServerConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Socket Server 模式运行",
          style: TextStyle(fontSize: 26),
        ),
        Row(
          children: <Widget>[
            Text("端口号："),
            Expanded(
              child: TextField(
                controller: _serverPortController,
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        OutlineButton(
          child: Text("启动"),
          onPressed: () {
            widget._createServerCallback
                .call(int.parse(_serverPortController.text));
            widget._goToChatPage(context);
          },
        )
      ],
    );
  }

  Widget getClientConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Socket Client 模式运行",
          style: TextStyle(fontSize: 26),
        ),
        Row(
          children: <Widget>[
            Text("Server IP："),
            Expanded(
              child: TextField(
                controller: _clientAddressController,
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text("Server 端口号："),
            Expanded(
              child: TextField(
                controller: _clientPortController,
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        OutlineButton(
          child: Text("启动"),
          onPressed: () {
            widget._createClientCallback.call(
                _clientAddressController.text,
                int.parse(_clientPortController.text));
            widget._goToChatPage(context);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("设置首页"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getDeviceInfo(),
                  SizedBox(
                    height: 12,
                  ),
                  getServerConfig(),
                  SizedBox(
                    height: 12,
                  ),
                  getClientConfig(),
                  SizedBox(
                    height: 12,
                  ),
                  Text("注：先在一台设备启动 Server，再用另一台连接"),
                ],
              )),
        ));
  }
}