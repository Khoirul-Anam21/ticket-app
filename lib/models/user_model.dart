import 'package:ticket_app/models/event_model.dart';
import 'package:ticket_app/models/ticket_model.dart';

class UserModel {
  String? name;
  String? telpNumber;
  String? newName;
  String? newTelpNumber;
  int? saldo;
  List<TicketModel>? myTickets;
  List<EventModel>? myFavouriteEvents;

  UserModel({
    this.name = 'Anam',
    this.telpNumber = '087894524561',
    this.myTickets,
    this.saldo,
  });

  set addMyTicket(TicketModel value) {
    // List.from(myTickets!)..add(value);
    myTickets = [...myTickets!, value];
  }

  String get userName {
    return name!;
  }

  int get userSaldo {
    return saldo!;
  }
}
