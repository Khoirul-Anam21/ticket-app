import 'dart:math';

import 'package:ticket_app/models/ticket_model.dart';

List<TicketModel> myTickets = <TicketModel>[];


/// [getID] mengambil ID dari [addID]
String getID() {
  List<String> ids = idStorage.toList();
  return ids[ids.length - 1];
}

String addID() {
  Random rand = Random();
  final String alphabet = 'abcdefghijklmnopqrstuvwxyz';
  final String number = '1234567890';
  List<String> alphabetChars = alphabet.split('');
  List<String> numberChars = number.split('');
  List<String> joinedChars = [...alphabetChars, ...numberChars];
  List<String> id = [];
  for (int index = 0; index < 9; index++) {
    id.add(joinedChars[rand.nextInt(joinedChars.length - 1) + 0]);
  }
  String result = id.join().toUpperCase();
  return result;
}

Set<String> idStorage = {};
