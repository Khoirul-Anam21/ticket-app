import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_app/data/data_tickets.dart';
import 'package:ticket_app/data/user_data.dart' as dataUser;

import 'package:ticket_app/models/event_model.dart';
import 'package:ticket_app/models/ticket_model.dart';
import 'package:ticket_app/models/user_model.dart';

import 'package:ticket_app/pages/main_page.dart';

class TicketFormPage extends StatelessWidget {
  const TicketFormPage({Key? key, this.eventModel}) : super(key: key);

  final EventModel? eventModel;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('Pemesanan Tiket'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage())))
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          bool haveWideAndPortraitScreen =
              constraints.maxWidth > 750 && orientation == Orientation.portrait;
          bool haveWideAndLandScapeScreen = constraints.maxWidth > 750 &&
              orientation == Orientation.landscape;

          if (haveWideAndLandScapeScreen) {
            return TicketFormPC(
              event: eventModel!,
            );
          } else if (haveWideAndPortraitScreen) {
            //ipad availability
            return TicketFormPC(
              event: eventModel!,
            );
          }
          return TicketFormMobile(
            eventValue: eventModel!,
          );
        }));
  }
}

class TicketFormPC extends StatefulWidget {
  const TicketFormPC({
    Key? key,
    required this.event,
  }) : super(key: key);
  final EventModel event;

  @override
  _TicketFormPCState createState() => _TicketFormPCState();
}

class _TicketFormPCState extends State<TicketFormPC> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Stack(children: <Widget>[
      Row(children: <Widget>[
        Expanded(flex: 3, child: Container()),
        Expanded(
          flex: 2,
          child: Container(color: Theme.of(context).primaryColor),
        )
      ]),
      Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _screenSize.width > 920 ? 45 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ayo Pesan Tiketmu', style: TextStyle(fontSize: 24)),
                      Text('Event besar sedang menunggumu!',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _screenSize.width > 920 ? 45 : 20),
                  height: _screenSize.width > 750 && isPortrait ? 720 : 320,
                  child: _screenSize.width > 750 && isPortrait
                      ? Column(
                          children: [
                            renderEventOverview(),
                            const SizedBox(
                              height: 30,
                            ),
                            renderUserAndSaldo(dataUser.userCentralData),
                          ],
                        )
                      : Row(
                          children: [
                            renderEventOverview(),
                            renderUserAndSaldo(dataUser.userCentralData),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget renderUserAndSaldo(UserModel user) {
    return Expanded(
        flex: 1,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: const Color(0xffCCEEDD),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 4,
                      spreadRadius: 3,
                      color: Colors.black.withOpacity(0.3))
                ]),
            padding: const EdgeInsets.all(30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserInfo(),
                  const SizedBox(height: 10),
                  PriceInfo(event: widget.event),
                  Divider(),
                  MySaldoSection(eventValue: widget.event),
                  OrderButtons(
                    eventValue: widget.event,
                  )
                ])));
  }

  Widget renderEventOverview() {
    return Expanded(
      flex: 1,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: Colors.black45)),
          padding: const EdgeInsets.all(30),
          child: EventOverview(event: widget.event)),
    );
  }
}

class TicketFormMobile extends StatefulWidget {
  const TicketFormMobile({
    Key? key,
    required this.eventValue,
  }) : super(key: key);

  final EventModel eventValue;

  @override
  _TicketFormMobileState createState() => _TicketFormMobileState();
}

class _TicketFormMobileState extends State<TicketFormMobile> {
  ScrollController? _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        renderBackground(context),
        Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      //event overview
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: const Color(0xffCCEEDD),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: const Offset(0, 3),
                                blurRadius: 4,
                                spreadRadius: 3,
                                color: Colors.black.withOpacity(0.3))
                          ]),
                      height: 360,
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: const EdgeInsets.all(30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            EventOverview(event: widget.eventValue),
                            UserInfo()
                          ])),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PriceInfo(event: widget.eventValue),
                        Divider(),
                        Container(
                            child:
                                MySaldoSection(eventValue: widget.eventValue)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: OrderButtons(eventValue: widget.eventValue))
      ],
    );
  }

  Widget renderBackground(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28))),
          )),
      Expanded(flex: 3, child: SizedBox.expand())
    ]);
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController? _nameController;
  TextEditingController? _telpController;
  UserModel? user;
  @override
  void initState() {
    user = dataUser.userCentralData;
    user!.newName = user!.name;
    user!.newTelpNumber = user!.telpNumber;
    _nameController = TextEditingController(text: user!.name);
    _telpController = TextEditingController(text: user!.telpNumber);
    super.initState();
  }

  void editName(String name) {
    setState(() {
      user!.newName = name;
    });
  }

  void editTelp(String telp) {
    setState(() {
      user!.newTelpNumber = telp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Atas Nama',
          style: TextStyle(fontSize: 12),
        ),
        Wrap(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(),
              onChanged: (value) {
                editName(value);
              },
              onSubmitted: (value) {
                editName(value);
              },
            ),
            TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                onChanged: (value) {
                  editTelp(value);
                },
                onSubmitted: (value) {
                  editTelp(value);
                },
                controller: _telpController,
                decoration: InputDecoration()),
          ],
        ),
      ],
    );
  }
}

class PriceInfo extends StatelessWidget {
  const PriceInfo({Key? key, required this.event}) : super(key: key);
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    bool _isPCScreen = MediaQuery.of(context).size.width > 750;
    return _isPCScreen
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Text('Harga',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16, color: Colors.black54)),
                Text('Rp. ${event.ticketPrice!}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 20))
              ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text('Harga',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16, color: Colors.black54)),
                Text('Rp. ${event.ticketPrice!}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 20))
              ]);
  }
}

class EventOverview extends StatelessWidget {
  const EventOverview({Key? key, required this.event}) : super(key: key);
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    bool isPCScreen = _screenSize.width > 1050;
    bool isTabScreen = _screenSize.width > 780;
    final overViewTitle =
        Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20);
    final overViewSubtitle =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14);
    var alignStart = MainAxisAlignment.start;
    var alignCenter = MainAxisAlignment.center;
    var justifyStart = CrossAxisAlignment.start;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Row(
      children: <Widget>[
        _screenSize.width > 300
            ? SizedBox(
                height: isPortrait && _screenSize.width > 750
                    ? 280
                    : isPCScreen
                        ? 250
                        : isTabScreen
                            ? 180
                            : 100,
                width: isPortrait && _screenSize.width > 750
                    ? 280
                    : isPCScreen
                        ? 250
                        : isTabScreen
                            ? 180
                            : 100,
                child: Hero(
                    tag: event.eventName!,
                    child: Image.network(event.mainImage!, fit: BoxFit.cover)))
            : SizedBox.shrink(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: _screenSize.width > 300 ? 20 : 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    isPCScreen && isPortrait ? alignStart : alignCenter,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: justifyStart,
                    children: [
                      isPCScreen
                          ? Text('Nama Event ')
                          : SizedBox.shrink(),
                      Text(event.eventName!, style: overViewTitle),
                    ],
                  ),
                  isTabScreen
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox.shrink(),
                  Column(
                    crossAxisAlignment: justifyStart,
                    children: [
                      isPCScreen ? Text('Waktu Event') : SizedBox.shrink(),
                      Text(event.eventDate!, style: overViewSubtitle),
                      Text(event.eventTime!, style: overViewSubtitle)
                    ],
                  ),
                  isTabScreen
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox.shrink(),
                  Column(
                    crossAxisAlignment: justifyStart,
                    children: [
                      isPCScreen ? Text('Alamat Event') : SizedBox.shrink(),
                      Text(event.eventAddress!, style: overViewSubtitle),
                    ],
                  )
                ]),
          ),
        )
      ],
    );
  }
}

class OrderButtons extends StatefulWidget {
  const OrderButtons({Key? key, this.eventValue}) : super(key: key);
  final EventModel? eventValue;

  @override
  _OrderButtonsState createState() => _OrderButtonsState();
}

class _OrderButtonsState extends State<OrderButtons> {
  void backToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainPage();
    }));
  }

  void showConfirmDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              runAlignment: WrapAlignment.center,
              children: [
                Image.asset('assets/checked_48px.png'),
                Text('Berhasil'),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pemesanan Tiket Berhasil'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ke Menu Utama'),
                onPressed: () => backToHome(),
              )
            ],
          );
        });
  }

  int calculateSaldo(int initSaldo, int price) {
    return initSaldo - price;
  }

  int calculateStock(int initStock) {
    return --initStock;
  }

  int calculateSold(int initSoldTicket) {
    return ++initSoldTicket;
  }

  ButtonStyle _buttonOrderStyle() {
    return ButtonStyle(textStyle: MaterialStateProperty.resolveWith((states) {
      return TextStyle(fontSize: 16);
    }), foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.black45;
      }
      return Colors.white;
    }), backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey;
      }
      return Color(0xff007E80);
    }), padding: MaterialStateProperty.resolveWith((states) {
      return EdgeInsets.symmetric(horizontal: 45, vertical: 15);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final eventValue = widget.eventValue;
    bool isSaldoEnough =
        eventValue!.ticketPrice! <= dataUser.userCentralData.saldo!;
    bool _isPCScreen = MediaQuery.of(context).size.width > 750;
    return Container(
        color: _isPCScreen ? null : Colors.white,
        width: double.infinity,
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: _buttonOrderStyle(),
                child: Text('Pesan'),
                onPressed: isSaldoEnough
                    ? () {
                        orderTicket(eventValue, dataUser.userCentralData);
                      }
                    : null,
              )
            ]));
  }

  void orderTicket(EventModel eventValue, UserModel userValue) {
    idStorage.add(addID());
    return setState(() {
      userValue.addMyTicket =
          TicketModel(ticketID: getID(), event: eventValue, user: userValue);
      userValue.saldo =
          calculateSaldo(userValue.saldo!, eventValue.ticketPrice!);
      eventValue.ticketStock = calculateStock(eventValue.ticketStock!);
      eventValue.popularity = calculateSold(eventValue.popularity!);
      showConfirmDialog();
    });
  }
}

class MySaldoSection extends StatefulWidget {
  MySaldoSection({Key? key, this.eventValue}) : super(key: key);
  final EventModel? eventValue;
  @override
  _MySaldoSectionState createState() => _MySaldoSectionState();
}

class _MySaldoSectionState extends State<MySaldoSection> {
  Widget saldoChecker(bool isSaldoEnough) {
    if (!isSaldoEnough) {
      return Text('Maaf Saldo Anda Tidak Cukup',
          style: TextStyle(color: Colors.red, fontSize: 12));
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    bool _isSaldoEnough =
        widget.eventValue!.ticketPrice! <= dataUser.userCentralData.saldo!;
    bool _isPCScreen = MediaQuery.of(context).size.width > 750;
    return _isPCScreen
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Text('Saldo Anda:',
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Rp. ${dataUser.userCentralData.saldo!}',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    saldoChecker(_isSaldoEnough),
                  ],
                ),
              ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Saldo Anda:',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              Text('Rp. ${dataUser.userCentralData.saldo}',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              saldoChecker(_isSaldoEnough),
            ],
          );
  }
}
