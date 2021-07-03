import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_app/data/data_events.dart';

import 'package:ticket_app/data/user_data.dart' as dataUser;
import 'package:ticket_app/models/event_model.dart';
import 'package:ticket_app/models/ticket_model.dart';
import 'package:ticket_app/models/user_model.dart';
import 'package:ticket_app/pages/events_page.dart';

import 'package:ticket_app/pages/ticket_detail.dart';




class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EventModel> _favouriteEvents =
        events.where((element) => element.isFavouriteEvent == true).toList();
    return Container(
      margin: EdgeInsets.only(top: 20, left: 28, right: 28),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined, size: 35),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        dataUser.userCentralData.name!,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  color: Color(0xff007E80),
                  icon: Icon(
                    Icons.favorite,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventsPage(
                              listEvents: _favouriteEvents,
                              title: 'Event Favorit'))))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SaldoInfo(userValue: dataUser.userCentralData),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Tiket Saya',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black45)),
            ),
          ),
          Expanded(child: MyTicket()),
        ],
      ),
    );
  }
}

class MyTicket extends StatefulWidget {
  const MyTicket({
    Key? key,
  }) : super(key: key);

  @override
  _MyTicketState createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = dataUser.userCentralData;
    bool isPCScreen = MediaQuery.of(context).size.width > 750;
    bool isTicketEmpty = user.myTickets!.length == 0;
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: isTicketEmpty
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.no_sim,
                          color: isPCScreen ? Colors.white70 : Colors.black),
                      Text(
                        'Belum Ada Tiket',
                        style: TextStyle(
                            color:
                                isPCScreen ? Colors.white54 : Colors.black54),
                      )
                    ]),
              )
            : ListView.builder(
                itemCount: user.myTickets!.length,
                itemBuilder: (BuildContext context, int index) {
                  final TicketModel ticketValue = user.myTickets![index];
                  return TicketTile(ticketValue: ticketValue);
                }));
  }
}

class TicketTile extends StatefulWidget {
  const TicketTile({
    Key? key,
    required this.ticketValue,
  }) : super(key: key);

  final TicketModel ticketValue;

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  Tween<double> _scaleTween = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: _scaleTween,
      duration: Duration(milliseconds: 300),
      builder: (context, double scaleAnimation, child) {
        return Transform.scale(
            scale: scaleAnimation,
            alignment: Alignment.centerLeft,
            origin: Offset(0, 3),
            child: child);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xffCCEEDD)),
        child: ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TicketDetailPage(
                    ticket: widget.ticketValue,
                  ))),
          leading: Image.asset('assets/ticket_48px.png'),
          title: Text(widget.ticketValue.event!.eventName!,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(widget.ticketValue.event!.eventDate!),
        ),
      ),
    );
  }
}

class SaldoInfo extends StatefulWidget {
  const SaldoInfo({Key? key, required this.userValue}) : super(key: key);
  final UserModel? userValue;
  @override
  _SaldoInfoState createState() => _SaldoInfoState();
}

class _SaldoInfoState extends State<SaldoInfo> {
  //button Style

  @override
  Widget build(BuildContext context) {
    final bool isPCScreen = MediaQuery.of(context).size.width > 800;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.amberAccent[100],
          boxShadow: isPCScreen
              ? null
              : <BoxShadow>[
                  BoxShadow(
                      offset: const Offset(0, 15),
                      blurRadius: 10,
                      color: Colors.black12.withOpacity(0.15),
                      spreadRadius: -8)
                ]),
      child: Row(children: <Widget>[
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text('Saldo e-Money', style: TextStyle(color: Colors.black45)),
              Text(
                'Rp. ${widget.userValue!.saldo}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87),
              )
            ])),
        CircleAvatar(
            backgroundColor: Color(0xff007E80),
            child: IconButton(
                onPressed: () => showTopUpDialog(), icon: Icon(Icons.add)))
      ]),
    );
  }

  void changeMoney(int value) {
    setState(() {
      int? tempMoney = widget.userValue!.saldo;
      if (tempMoney != null) {
        widget.userValue!.saldo = tempMoney + value;
      }
    });
  }

  void showTopUpDialog() {
    TextEditingController _textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Masukkan Nominal TopUp'),
            content: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: 'Masukkan Nominal',
                  hintText: 'Masukkan Nominal Top-Up',
                  focusColor: Color(0xff007E80)),
              controller: _textController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Batal'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 15, vertical: 6)),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xff007E80))
                ),
                child: Text('Konfirmasi',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  int tempValue = int.parse(_textController.text);
                  changeMoney(tempValue);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      showSuccessTopUpSnackBar(_textController));
                },
              )
            ],
          );
        });
  }

  SnackBar showSuccessTopUpSnackBar(TextEditingController _textController) {
    return SnackBar(
      backgroundColor: Colors.green[800],
      content: Row(
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(
            width: 10,
          ),
          Text('Top-Up sebesar Rp. ${_textController.text}'),
        ],
      ),
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
