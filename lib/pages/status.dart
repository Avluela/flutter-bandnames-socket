import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('ServerStatus: ${socketService.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tarea
          // Emitir:
          // { nombre: 'Flutter', mensaje: 'Hola desde FLutter'}

          socketService.socket.emit('emitir-mensaje', {
            "nombre": 'Flutter',
            "mensaje": 'Hola desde FLutter',
          });
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
