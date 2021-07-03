import 'package:flutter/material.dart';
import 'package:ticket_app/models/event_model.dart';
import 'package:ticket_app/models/ticket_model.dart';

import 'package:ticket_app/pages/main_page.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({Key? key, this.ticket}) : super(key: key);

  final TicketModel? ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                color: Colors.black87,
                icon: Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context)),
            actions: <Widget>[
              IconButton(
                  color: Colors.black87,
                  icon: Icon(Icons.home_outlined),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainPage())))
            ]),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 750) {
              return TicketDetailPC(
                ticketOrdered: ticket!,
              );
            }
            return TicketDetailMobile(ticketOrdered: ticket!);
          },
        ));
  }
}

class TicketDetailPC extends StatelessWidget {
  const TicketDetailPC({Key? key, required this.ticketOrdered})
      : super(key: key);
  final TicketModel ticketOrdered;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ThankingQuote(),
          const SizedBox(
            height: 20,
          ),
          Row(children: <Widget>[
            Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  EventName(event: ticketOrdered.event),
                  const Divider(),
                  PriceInfo(ticketOrdered: ticketOrdered),
                ])),
            const SizedBox(width: 15),
            Expanded(
                flex: 1, child: TicketInfoBox(ticketOrdered: ticketOrdered))
          ])
        ],
      ),
    );
  }
}

class EventName extends StatelessWidget {
  const EventName({
    Key? key,
    required this.event,
  }) : super(key: key);

  final EventModel? event;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 100,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        SizedBox(
            width: 100,
            child: SizedBox.expand(
                child: Image.network(event!.mainImage!, fit: BoxFit.cover))),
        const SizedBox(width: 10),
        Expanded(
            child: Text(event!.eventName!,
                style: _textTheme.headline6!.copyWith(fontSize: 20)))
      ]),
    );
  }
}

class ThankingQuote extends StatelessWidget {
  const ThankingQuote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textStyle = Theme.of(context).textTheme;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Terima kasih atas pesananmu', style: _textStyle.headline1),
          const SizedBox(height: 20),
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450),
              child: Text(
                  'Jangan lupa hadiri dan meriahkan event ini kami tunggu kehadiranmu',
                  style: _textStyle.bodyText2!.copyWith(fontSize: 16)))
        ]);
  }
}

class TicketDetailMobile extends StatelessWidget {
  const TicketDetailMobile({Key? key, required this.ticketOrdered})
      : super(key: key);
  final TicketModel ticketOrdered;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ThankingQuote(),
              const Divider(),
              EventName(event: ticketOrdered.event),
              const Divider(),
              TicketInfoBox(ticketOrdered: ticketOrdered),
              const Divider(),
              PriceInfo(ticketOrdered: ticketOrdered),
              const Divider(),
            ]),
      ),
    );
  }
}

class PriceInfo extends StatelessWidget {
  const PriceInfo({
    Key? key,
    required this.ticketOrdered,
  }) : super(key: key);

  final TicketModel ticketOrdered;

  @override
  Widget build(BuildContext context) {
    final bool isPCScreen = MediaQuery.of(context).size.width > 750;
    final TextStyle _textTitleStyle = TextStyle(
      fontSize: isPCScreen?20:16,
      color: Colors.black54,
    );
    final TextStyle _textInfoStyle = TextStyle(
      fontSize: isPCScreen?20:16,
      color: Colors.black87,
    );
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Harga', style: _textTitleStyle),
                Text('Rp. ${ticketOrdered.event!.ticketPrice!}',
                    style: _textInfoStyle)
              ]),
          isPCScreen? Divider():SizedBox.shrink(),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Icon(Icons.info_outline, size: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Text('Tunjukkan Halaman ini ketika memasuki Event anda',
                  style: _textTitleStyle.copyWith(fontSize: 14)),
            )
          ])
        ],
      ),
    );
  }
}

class TicketInfoBox extends StatelessWidget {
  const TicketInfoBox({
    Key? key,
    required this.ticketOrdered,
  }) : super(key: key);

  final TicketModel ticketOrdered;

  Widget renderTicketInfo(
    String keyInfo,
    String value,
  ) {
    final TextStyle _textTitleStyle = TextStyle(
      fontSize: 16,
      color: Colors.white70,
    );
    final TextStyle _textInfoStyle =
        TextStyle(fontSize: 16, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(keyInfo, style: _textTitleStyle),
            Text(value, style: _textInfoStyle)
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: <Widget>[
            renderTicketInfo('ID Tiket', ticketOrdered.ticketID!),
            renderTicketInfo('Nama Peserta', ticketOrdered.user!.newName!),
            renderTicketInfo('No. Telp', ticketOrdered.user!.newTelpNumber!),
            renderTicketInfo('Waktu', ticketOrdered.event!.eventTime!),
            renderTicketInfo('Tanggal', ticketOrdered.event!.eventDate!),
            renderTicketInfo('Alamat', ticketOrdered.event!.eventAddress!),
          ],
        ));
  }
}
