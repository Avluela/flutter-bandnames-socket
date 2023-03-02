import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Estos siempre va a estar escuchando
    // Lo recomendable aqui es definir los metodos que vaya a estar escuchando de manera transversal en toda la app

    // Dart client
    _socket = IO.io('http://10.0.2.2:3000',
        OptionBuilder().setTransports(['websocket']).build());

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // //En el caso del evento de nuevo mensaje, si no va a ser necesario estar escuchando
    // //en todos lados dentro de la aplicacion se debería definir de otra manera
    // //lo recomendable es exponer el socket para que sea llamado cuando se lo necesita
    //
    // socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje:' + payload);
    //   // print('nombre: ' + payload['nombre']);
    //   // print('mensaje: ' + payload['mensaje']);
    //   // print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    // });
  }
}
