import 'package:flutter/material.dart';

import 'package:ticket_app/models/event_model.dart';

import 'package:ticket_app/pages/ticket_form.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({Key? key, this.eventModel}) : super(key: key);
  final EventModel? eventModel;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      bool haveWideAndPortraitScreen =
          constraints.maxWidth > 750 && orientation == Orientation.portrait;
      bool haveWideAndLandScapeScreen =
          constraints.maxWidth > 750 && orientation == Orientation.landscape;

      if (haveWideAndLandScapeScreen) {
        return EventDetailPagePC(eventModel: eventModel);
      } else if (haveWideAndPortraitScreen) {
        //ipads/big tablet
        return EventDetailPageMobile(
          eventModel: eventModel,
        );
      }
      return EventDetailPageMobile(
        eventModel: eventModel,
      );
    }));
  }
}

class EventDetailPageMobile extends StatefulWidget {
  EventDetailPageMobile({
    Key? key,
    this.eventModel,
  }) : super(key: key);
  final EventModel? eventModel;

  @override
  _EventDetailPageMobileState createState() => _EventDetailPageMobileState();
}

//detail event
class _EventDetailPageMobileState extends State<EventDetailPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        detailEventWithSliver(),
        PriceAndStockBar(eventValue: widget.eventModel!)
      ],
    );
  }

  Widget detailEventWithSliver() {
    final EventModel eventValue = widget.eventModel!;
    //detail event
    return CustomScrollView(
      slivers: <Widget>[
        scrollableAppBar(eventValue),
        SliverList(
            delegate: SliverChildListDelegate([
          EventIdentitySection(
            event: eventValue,
          ),
          DetailImageSlider(eventValue: eventValue),
          const Divider(),
          DetailTexts(eventValue: eventValue),
          // const SizedBox(height: 90)
        ]))
      ],
    );
  }

  Widget scrollableAppBar(EventModel eventValue) {
    return SliverAppBar(
      title: Text('Detail Event ',
          style: const TextStyle(shadows: <Shadow>[
            Shadow(
                offset: Offset(-0.5, -0.5),
                color: Colors.black45,
                blurRadius: 1),
            Shadow(
                offset: Offset(0.5, -0.5),
                color: Colors.black45,
                blurRadius: 1),
            Shadow(
                offset: Offset(-0.5, 0.5),
                color: Colors.black45,
                blurRadius: 1),
            Shadow(
                offset: Offset(0.5, 0.5), color: Colors.black45, blurRadius: 1)
          ])),
      leading: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.chevron_left,
                size: 28,
              ),
              color: Colors.black),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left),
              color: Colors.white),
        ],
      ),
      backgroundColor: const Color(0xff007E80),
      pinned: true,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
            tag: widget.eventModel!.eventName!,
            child: Image.network(eventValue.mainImage!, fit: BoxFit.cover)),
      ),
    );
  }
}

///[PriceAndStockBar] untuk bar harga dan stok dengan tombol pesan
class PriceAndStockBar extends StatelessWidget {
  const PriceAndStockBar({Key? key, this.eventValue}) : super(key: key);
  final EventModel? eventValue;

  @override
  Widget build(BuildContext context) {
    final bool isPCScreen = MediaQuery.of(context).size.width > 800;
    final bool isTicketOutOfStock = eventValue!.ticketStock! == 0;
    return Align(
        alignment: Alignment.bottomCenter,
        child: isPCScreen
            ? bottomBarSection(isPCScreen, isTicketOutOfStock, context)
            : Container(
                height: 60,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffCCEEDD),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          offset: const Offset(2, 4),
                          blurRadius: 6,
                          spreadRadius: 1,
                          color: Colors.black38)
                    ]),
                child:
                    bottomBarSection(isPCScreen, isTicketOutOfStock, context)));
  }

  Widget bottomBarSection(
      bool isPCScreen, bool isTicketOutOfStock, BuildContext context) {
    return Container(
      height: isPCScreen ? 60 : null,
      width: double.infinity,
      child: Center(child: orderButton(isTicketOutOfStock, context)),
    );
  }

  Widget orderButton(bool isTicketOutOfStock, BuildContext context) {
    return SizedBox.expand(
      child: TextButton(
          //tombol pesan tiket
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pesan Tiket',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.shopping_cart_rounded)
            ],
          ),
          onPressed: isTicketOutOfStock
              ? null
              : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TicketFormPage(eventModel: eventValue))),
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith((states) {
            return Size.fromHeight(80);
          }), shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20));
          }), padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.symmetric(horizontal: 35, vertical: 20);
          }), backgroundColor: MaterialStateProperty.resolveWith((states) {
            return Color(0xff007E80);
          }), foregroundColor: MaterialStateProperty.resolveWith((states) {
            return Colors.white70;
          }))),
    );
  }
}

///[DetailTexts] memuat teks dari detail
class DetailTexts extends StatelessWidget {
  const DetailTexts({
    Key? key,
    required this.eventValue,
  }) : super(key: key);

  final EventModel eventValue;

  @override
  Widget build(BuildContext context) {
    final bool isPCScreen = MediaQuery.of(context).size.width > 800;
    final EdgeInsets _textPadding = const EdgeInsets.symmetric(horizontal: 20);
    final TextStyle _subTitleStyle = const TextStyle(
        fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 16);
    final TextStyle? _bodyText =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13);
    final CrossAxisAlignment leftIndent = CrossAxisAlignment.start;

    //detail event
    final String? description = eventValue.eventDescription;
    final String? address = eventValue.eventAddress;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _textPadding,
          child: Column(crossAxisAlignment: leftIndent, children: <Widget>[
            isPCScreen
                ? SelectableText('Alamat', style: _subTitleStyle)
                : Text('Alamat', style: _subTitleStyle),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14),
                const SizedBox(width: 4),
                isPCScreen
                    ? SelectableText(address!, style: _bodyText)
                    : Text(address!, style: _bodyText),
              ],
            )
          ]),
        ),
        const Divider(),
        Padding(
          padding: _textPadding,
          child: Column(crossAxisAlignment: leftIndent, children: <Widget>[
            isPCScreen
                ? SelectableText('Deskripsi', style: _subTitleStyle)
                : Text('Deskripsi', style: _subTitleStyle),
            const SizedBox(
              height: 15,
            ),
            isPCScreen
                ? SelectableText(description!, style: _bodyText)
                : Text(description!, style: _bodyText)
          ]),
        ),
        const SizedBox(
          height: 95,
        )
      ],
    );
  }
}

class EventIdentitySection extends StatefulWidget {
  EventIdentitySection({Key? key, this.event}) : super(key: key);
  final EventModel? event;

  @override
  _EventIdentitySectionState createState() => _EventIdentitySectionState();
}

class _EventIdentitySectionState extends State<EventIdentitySection> {
  @override
  Widget build(BuildContext context) {
    final bool isPCScreen = MediaQuery.of(context).size.width > 750;
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffCCEEDD),
          borderRadius: isPCScreen ? BorderRadius.circular(20) : null),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: identityDetailSection(context),
    );
  }

  Widget identityDetailSection(BuildContext context) {
    final TextStyle detailStyle = Theme.of(context).textTheme.caption!;
    final double iconSize = 20.0;
    final Color iconColour = Colors.black54;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(widget.event!.eventName!,
              style: Theme.of(context).textTheme.headline1),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Wrap(children: <Widget>[
            Wrap(children: <Widget>[
              Icon(Icons.access_time, size: iconSize, color: iconColour),
              SizedBox(width: 3),
              Text(widget.event!.eventTime!, style: detailStyle),
              const SizedBox(width: 35),
            ]),
            Wrap(children: <Widget>[
              Icon(Icons.calendar_today, size: iconSize, color: iconColour),
              SizedBox(width: 3),
              Text(widget.event!.eventDate!, style: detailStyle)
            ])
          ]),
        ),
        const SizedBox(
          height: 4,
        ),
        wrapPriceAndStock(detailStyle, iconColour),
      ],
    );
  }

  Widget wrapPriceAndStock(TextStyle detailStyle, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rp. ${widget.event!.ticketPrice!}',
                  style: detailStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Stok : ',
                    style: detailStyle.copyWith(
                        color: Colors.black54, fontSize: 13)),
                TextSpan(
                    text: '${widget.event!.ticketStock}',
                    style: detailStyle.copyWith(
                        fontSize: 13, color: Colors.black87))
              ])),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Terjual : ',
                    style: detailStyle.copyWith(
                        color: Colors.black54, fontSize: 14)),
                TextSpan(
                    text: '${widget.event!.popularity}',
                    style: detailStyle.copyWith(
                        fontSize: 14, color: Colors.black87))
              ])),
            ],
          ),
          // const SizedBox(width: 35),
          Row(
            children: <Widget>[
              Column(children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      icon: widget.event!.isFavouriteEvent!
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_outline),
                      onPressed: () {
                        addToFavourite();
                      },
                    ),
                    Text(widget.event!.isFavouriteEvent!
                        ? 'Ditambahkan ke Favorit'
                        : 'Favorit')
                  ],
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }

  void addToFavourite() {
    return setState(() {
      bool? isFavourite = widget.event!.isFavouriteEvent;
      isFavourite = !isFavourite!;
      isFavourite
          ? widget.event!.isFavouriteEvent = true
          : widget.event!.isFavouriteEvent = false;
    });
  }
}

class DetailImageSlider extends StatelessWidget {
  const DetailImageSlider({
    Key? key,
    required this.eventValue,
  }) : super(key: key);

  final EventModel? eventValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventValue!.imageURLs!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                        eventValue!.imageURLs![index],
                      ),
                      fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}

class EventDetailPagePC extends StatelessWidget {
  const EventDetailPagePC({Key? key, this.eventModel}) : super(key: key);
  final EventModel? eventModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[backgroundSection(context), eventDetailSection()]);
  }

  Widget eventDetailSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
      child: Row(children: <Widget>[imagesSection(), textsSection()]),
    );
  }

  Widget textsSection() {
    return Expanded(
        child: Container(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: Stack(children: <Widget>[
          EventContent(eventModel: eventModel),

          //layer 2
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(left: 20),
                    child: Center(
                      child: Text('Detail Event',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.black54)),
                    ),
                    width: double.infinity,
                    height: 45),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: PriceAndStockBar(
                    eventValue: eventModel!,
                  ),
                ),
              ])
        ]),
      ),
    ));
  }

  Widget imagesSection() {
    return Expanded(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
              clipBehavior: Clip.antiAlias,
              height: 300,
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: const Offset(6, 6),
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 8,
                      spreadRadius: 2)
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: SizedBox.expand(
                child: Hero(
                    tag: eventModel!.eventName!,
                    child: Image.network(eventModel!.mainImage!,
                        fit: BoxFit.cover)),
              )),
          DetailImageSlider(
            eventValue: eventModel!,
          )
        ]),
      ),
    ));
  }

  Widget backgroundSection(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              color: const Color(0xff007E80),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 15, left: 40),
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Icon(Icons.chevron_left,
                          size: 28, color: Colors.white)),
                ),
              ),
            )),
        Expanded(flex: 3, child: Container(color: Colors.white))
      ],
    );
  }
}

class EventContent extends StatefulWidget {
  const EventContent({
    Key? key,
    required this.eventModel,
  }) : super(key: key);

  final EventModel? eventModel;

  @override
  _EventContentState createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
              margin: const EdgeInsets.only(top: 60, bottom: 95),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: EventIdentitySection(event: widget.eventModel),
                  ),
                  DetailTexts(eventValue: widget.eventModel!),
                ],
              ))),
    );
  }
}
