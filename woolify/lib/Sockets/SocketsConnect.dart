import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/Sockets/Notification.dart';

class mySocketConnect {
  static late Socket socket;
  static void connect() async {
    socket = io(
        'http://localhost:8000'.replaceAll("localhost", ServerDetails.ip),
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            // .setExtraHeaders(ServerDetails.token) // optional
            .build());
    socket.connect();
    socket.onError(
        (data) => developer.log(data.toString(), name: "error on socket"));
    socket.on('notification', (data) {
      // developer.log(data.toString(), name: "socket notification recived");
      developer.log("hehey recived");
      CustomNotiFication.showNotification(
          title: data['content'], body: "Woolify");
      // developer.log(data.toString(), name: "Lisenting to sockets sshsh");
    });

    socket.onConnect(
        (data) => developer.log(data.toString(), name: "Connected to socket"));
  }
}
