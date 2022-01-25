import 'dart:io';
import 'dart:math';

import 'dart:typed_data';

void main() async {
  final List<Socket> communicateClients = [];
  final List<Socket> recvClients = [];
  final serverRecvData = await ServerSocket.bind(InternetAddress.anyIPv4, 9999);
  final serverCommunicate =
      await ServerSocket.bind(InternetAddress.anyIPv4, 9998);
  // final server = await ServerSocket.bind(InternetAddress.anyIPv4, 9999);
  print('server recv started');
  print('server communicate started');
  notifyCommunicateAllClient(String message) {
    for (var item in communicateClients) {
      print('Notify all communicate client ${item.remoteAddress.address}:${item.remotePort}');
      item.write(message + '\n');
    }
  }

  notifyRecvAllClient(String message) {
    for (var item in recvClients) {
      print('Notify all recv client ${item.remoteAddress.address}:${item.remotePort}');
      item.write(message + '\n');
    }
  }

  serverRecvData.listen((client) {
    print('Connection to recv data server from'
        ' ${client.remoteAddress.address}:${client.remotePort}');
    if (!recvClients.contains(client)) {
      recvClients.add(client);
    }
    // if (message.contains('result:')) {
    //   notifyCommunicateAllClient(message.replaceAll('result:', 'prediction:'));
    // }
    client.listen((Uint8List data) async {
      final message = String.fromCharCodes(data);
      print(
          'Client ${client.remoteAddress.address}:${client.remotePort} send message:'
          ' $message');
      if (message.contains('result:')) {
        notifyCommunicateAllClient(
            message.replaceAll('result:', 'prediction:'));
      }
    });
  });

  serverCommunicate.listen((client) async {
    print('Connection to communicate from'
        ' ${client.remoteAddress.address}:${client.remotePort}');
    if (!communicateClients.contains(client)) {
      communicateClients.add(client);
    }

    client.listen((Uint8List data) async {
      final message = String.fromCharCodes(data);
      print(
          'Client ${client.remoteAddress.address}:${client.remotePort} send message:'
          ' $message');
      if (message.contains('send:')) {
        notifyRecvAllClient(message.replaceAll('send:', ''));
      }
    });
  });

  // serverRecvData.listen((client) async {

  // });
}

// void handleConnection(Socket client) {
//   print('Connection from'
//       ' ${client.remoteAddress.address}:${client.remotePort}');

//   // listen for events from the client


//     // handle errors
//     onError: (error) {
//       print(error);
//       client.close();
//     },

//     // handle the client closing the connection
//     onDone: () {
//       print('Client left');
//       client.close();
//     },
//   );
// }
