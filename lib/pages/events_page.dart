import 'package:flutter/material.dart';

import 'package:ticket_app/models/event_model.dart';

import 'package:ticket_app/pages/event_detail.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key, required this.listEvents, this.title})
      : super(key: key);
  final String? title;
  final List<EventModel> listEvents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title '),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final smallScreenSize = 345;
        final mediumScreenSize = 700;
        final largeScreenSize = 950;
        final extraLargeScreenSize = 1280;
        return listEvents.isEmpty
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Image.asset('assets/event_declined_72px.png'),
                    Text('Belum ada event untuk kategori ini!',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]))
            : GridView.builder(
                itemCount: listEvents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth < smallScreenSize
                        ? 1
                        : constraints.maxWidth < mediumScreenSize
                            ? 2
                            : constraints.maxWidth < largeScreenSize &&
                                    constraints.maxWidth > mediumScreenSize
                                ? 3
                                : constraints.maxWidth < extraLargeScreenSize
                                    ? 4
                                    : 5,
                    childAspectRatio: constraints.maxWidth < smallScreenSize
                        ? 3 / 4
                        : constraints.maxWidth > mediumScreenSize &&
                                constraints.maxWidth < largeScreenSize
                            ? 3 / 4.5
                            : 3 / 5.5),
                itemBuilder: (context, index) {
                  final EventModel eventValue = listEvents[index];
                  return EventTile(
                    event: eventValue,
                  );
                });
      }),
    );
  }
}

class EventTile extends StatefulWidget {
  const EventTile({Key? key, this.event}) : super(key: key);
  final EventModel? event;

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailPage(
                    eventModel: widget.event,
                  ))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAlias,
          child: Center(
              child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox.expand(
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            child: Hero(
                              tag: widget.event!.eventName!,
                              child: Image.network(widget.event!.mainImage!,
                                  fit: BoxFit.cover),
                            )),
                      ),
                      Positioned(
                        bottom: -15,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffCCEEDD),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 15,
                              ),
                              Text('${widget.event!.popularity!}')
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              styleEventInfo(context)
            ],
          )),
        ),
      ),
    );
  }

  Widget styleEventInfo(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isSmallScreenSize = MediaQuery.of(context).size.width < 380 &&
        MediaQuery.of(context).size.width > 340;
    bool isMediumScreenSize = MediaQuery.of(context).size.width > 500 &&
        MediaQuery.of(context).size.width < 700;
    bool isOneTileScreen = MediaQuery.of(context).size.width < 345;
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styleEventName(isOneTileScreen, isMediumScreenSize, textTheme,
                isSmallScreenSize),
            styleEventIdentity(isOneTileScreen, isMediumScreenSize, textTheme,
                isSmallScreenSize),
          ],
        ),
      ),
    );
  }

  Widget styleEventIdentity(bool isOneTileScreen, bool isMediumScreenSize,
      TextTheme textTheme, bool isSmallScreenSize) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.calendar_today, size: 14),
              const SizedBox(
                width: 4,
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  child: Text(widget.event!.eventDate!,
                      style: isOneTileScreen || isMediumScreenSize
                          ? textTheme.bodyText2!.copyWith(fontSize: 12)
                          : isSmallScreenSize
                              ? textTheme.bodyText2!.copyWith(fontSize: 8)
                              : textTheme.bodyText2),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text('Rp. ${widget.event!.ticketPrice!}',
              style: isOneTileScreen || isMediumScreenSize
                  ? textTheme.bodyText1!.copyWith(fontSize: 20)
                  : isSmallScreenSize
                      ? textTheme.bodyText1!.copyWith(fontSize: 13)
                      : textTheme.bodyText1),
          Text(
            'Stok: ${widget.event!.ticketStock}',
            style: isOneTileScreen || isMediumScreenSize
                ? textTheme.bodyText2!.copyWith(fontSize: 12)
                : isSmallScreenSize
                    ? textTheme.bodyText2!.copyWith(fontSize: 8)
                    : textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  Widget styleEventName(bool isOneTileScreen, bool isMediumScreenSize,
      TextTheme textTheme, bool isSmallScreenSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.event!.eventName!,
          style: isOneTileScreen || isMediumScreenSize
              ? textTheme.headline6!.copyWith(fontSize: 20)
              : isSmallScreenSize
                  ? textTheme.headline6!.copyWith(fontSize: 13)
                  : textTheme.headline6,
        ),
      ),
    );
  }
}
