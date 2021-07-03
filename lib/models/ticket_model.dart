import 'package:ticket_app/models/event_model.dart';
import 'package:ticket_app/models/user_model.dart';

class TicketModel {
  final String? ticketID;
  final EventModel? event;
  final UserModel? user;

  TicketModel(
      {this.ticketID,
      this.event,
      this.user});
}
