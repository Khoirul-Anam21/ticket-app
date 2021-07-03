import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_app/data/data_events.dart';
import 'package:ticket_app/data/user_data.dart' as dataUser;

import 'package:ticket_app/models/event_model.dart';
import 'package:ticket_app/models/user_model.dart';
import 'package:ticket_app/pages/event_detail.dart';
import 'package:ticket_app/pages/events_page.dart';
import 'package:ticket_app/pages/login_page.dart';

import 'package:ticket_app/pages/user_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // final UserModel? user = UserWidget.of(context)!.user;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return MainPagePC();
      }
      return MainPageMobile();
    });
  }
}

class MainPageMobile extends StatelessWidget {
  const MainPageMobile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: const Color(0xffCCEEDD)),
        child: SafeArea(
          child: Scaffold(
            body: TabBarView(
              children: [
                renderMainTab(context),
                UserPage(),
              ],
            ),
            bottomNavigationBar: Material(
              color: const Color(0xff007E80),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16)),
              shadowColor: Colors.black,
              elevation: 30,
              child: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.home),
                    text: 'Menu Utama',
                  ),
                  Tab(icon: Icon(Icons.people), text: 'Saya')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget renderMainTab(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 25,
          right: 15,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 65),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang, ${dataUser.userCentralData.name}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ayo jelajahi event yang kau minati',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            SearchText(),
            const SizedBox(height: 20),
            ImagePopularSlider(),
            const Divider(),
            EventCategories()
          ],
        ),
      ),
      Column(children: <Widget>[
        placeTitle(_screenSize, context),
      ]),
    ]);
  }

  Widget placeTitle(Size _screenSize, BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 50,
        child: titleName(context),
      ),
    );
  }

  Widget titleName(BuildContext context) {
    bool isMiniScreen = MediaQuery.of(context).size.width < 360;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Menu Utama',
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          TextButton(
              child: Row(
                children: [
                  Text('Log out', style: TextStyle(color: Colors.black87)),
                  const SizedBox(width: 6),
                  isMiniScreen
                      ? SizedBox.shrink()
                      : Icon(Icons.logout, color: Colors.black87)
                ],
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())))
        ]);
  }
}

class SearchText extends StatefulWidget {
  SearchText({Key? key}) : super(key: key);

  @override
  _SearchTextState createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  TextEditingController _textSearchController = TextEditingController();
  List<EventModel>? _searchedEvents;

  @override
  void initState() {
    super.initState();
  }

  bool searchEvent(String searchValue, String data) {
    List<String> searchValueChars = searchValue.split('');
    List<String> dataChars = data.split('');
    int searchIterator = 0;
    for (int dataIterator = 0;
        dataIterator < dataChars.length;
        dataIterator++) {
      if (dataChars[dataIterator] == searchValueChars[searchIterator]) {
        searchIterator++;
      } else {
        searchIterator = 0;
      }

      if (searchIterator == searchValueChars.length) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    _textSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: _textSearchController,
      decoration: InputDecoration(
          hintText: 'Cari Event',
          labelText: 'Cari Event',
          suffixIcon: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () async {
                _searchedEvents = events
                    .where((element) => searchEvent(
                        _textSearchController.text.toLowerCase(),
                        element.eventName!.toLowerCase()))
                    .toList();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventsPage(
                            listEvents: _searchedEvents!,
                            title: 'Hasil Pencarian')));
              }),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}

class EventCategories extends StatefulWidget {
  const EventCategories({Key? key}) : super(key: key);

  @override
  _EventCategoriesState createState() => _EventCategoriesState();
}

class _EventCategoriesState extends State<EventCategories> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pilih Berdasarkan Kategori',
            style: TextStyle(fontSize: screenSize.width < 750 ? 12 : 14)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: screenSize.width > 750 || screenSize.height > 750 ? 160 : 120,
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 1),
              scrollDirection: Axis.horizontal,
              children: eventCategories.map((value) {
                value.isHovered = false;
                return CategoryTile(category: value);
              }).toList()),
        ),
      ],
    );
  }
}

class CategoryTile extends StatefulWidget {
  const CategoryTile({Key? key, this.category}) : super(key: key);

  final CategoryModel? category;
  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  List<EventModel>? filteredEvents;
  BoxDecoration normalStyle = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.amberAccent,
      boxShadow: <BoxShadow>[
        BoxShadow(
            offset: const Offset(2, 2),
            spreadRadius: 1,
            blurRadius: 2,
            color: Colors.black26)
      ]);
  void mouseHovered() {
    normalStyle = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amberAccent,
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: const Offset(4, 4),
              spreadRadius: 3,
              blurRadius: 4,
              color: Colors.black26)
        ]);
  }

  void mouseExited() {
    normalStyle = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amberAccent,
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: const Offset(2, 2),
              spreadRadius: 1,
              blurRadius: 2,
              color: Colors.black26)
        ]);
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteredEvents = events
        .where((value) => value.eventCategory! == widget.category!.value)
        .toList();
    bool isPCScreen = MediaQuery.of(context).size.width > 750;
    return MouseRegion(
      onHover: (event) {
        setState(() {
          mouseHovered();
        });
      },
      onExit: (event) {
        setState(() {
          mouseExited();
        });
      },

      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventsPage(
                    title: widget.category!.value,
                    listEvents: filteredEvents!))),
        child: AnimatedContainer(
            duration: Duration(milliseconds: 450),
            curve: Curves.easeIn,
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(right: 15, bottom: 20),
            decoration: normalStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.category!.logoSource!),
                Center(
                    child: Text(widget.category!.value!,
                        style: isPCScreen
                            ? Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14)
                            : Theme.of(context).textTheme.caption)),
              ],
            )),
      ),
    );
  }
}

class ImagePopularSlider extends StatefulWidget {
  const ImagePopularSlider({Key? key}) : super(key: key);

  @override
  _ImagePopularSliderState createState() => _ImagePopularSliderState();
}

class _ImagePopularSliderState extends State<ImagePopularSlider> {
  @override
  void initState() {
    events.sort((a, b) => b.popularity!.compareTo(a.popularity!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Event Populer',
              style: TextStyle(fontSize: screenSize.width < 750 ? 12 : 14)),
          renderImageSlider(),
        ]);
  }

  Widget renderImageSlider() {
    return Container(
        height: 200,
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final EventModel eventValue = events[index];
              bool isPopularEvent = eventValue.popularity! > 180;
              return isPopularEvent
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EventDetailPage(
                                  eventModel: eventValue,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, right: 20, bottom: 25, left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54.withOpacity(0.25),
                                    spreadRadius: 3,
                                    blurRadius: 12,
                                    offset: const Offset(6, 7))
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(children: <Widget>[
                              wrapImage(eventValue),
                              labelImage(eventValue, eventValue.popularity!)
                            ]),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }));
  }

  Widget labelImage(EventModel eventValue, int likeValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: 300,
          child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                runAlignment: WrapAlignment.center,
                direction: Axis.vertical,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      child: Icon(Icons.shopping_cart, 
                      color: Colors.white60)),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black.withOpacity(0.3)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 2),
                      child: Text('$likeValue',
                          style:
                              TextStyle(fontSize: 12, color: Colors.white60)))
                ],
              )),
        ),
        Container(
          width: 300,
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                    color: Color(0xff000000).withOpacity(0.35)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    eventValue.eventName!,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget wrapImage(EventModel eventValue) {
    return Container(
        width: 300,
        child: SizedBox.expand(
            child: Hero(
                tag: eventValue.eventName!,
                child:
                    Image.network(eventValue.mainImage!, fit: BoxFit.cover))));
  }
}

//udah termasuk user_page
class MainPagePC extends StatelessWidget {
  const MainPagePC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: <Widget>[
          renderUserSection(dataUser.userCentralData, context),
          dashboardSection(_screenSize, dataUser.userCentralData, context)
        ],
      ),
    );
  }

  Widget dashboardSection(
      Size _screenSize, UserModel user, BuildContext context) {
    return Expanded(
        flex: _screenSize.width > 1100 ? 3 : 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang, ${user.name!}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Ayo jelajahi event yang kau minati',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            SizedBox(width: 300, child: SearchText()),
                          ],
                        )),
                  ],
                ),

                const SizedBox(height: 20),
                ImagePopularSlider(),
                const Divider(),
                EventCategories()
                // ListEvent()
              ]),
            ),
            renderTitleSection(_screenSize, context),
          ],
        ));
  }

  Widget renderUserSection(UserModel userValue, BuildContext context) {
    List<EventModel> _favouriteEvents =
        events.where((element) => element.isFavouriteEvent == true).toList();
    return Expanded(
      // flex: 2,
      child: Container(
          padding: const EdgeInsets.all(20),
          color: const Color(0xff007E80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('${userValue.name!}',
                          style: TextStyle(fontSize: 28, color: Colors.white)),
                    ),
                    IconButton(
                        icon: Icon(Icons.favorite, color: Colors.white),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventsPage(
                                    listEvents: _favouriteEvents,
                                    title: 'Event Favorit'))))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SaldoInfo(userValue: userValue),
              const Divider(
                color: Colors.white70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text('Tiket Saya',
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 24)),
              ),
              Expanded(child: MyTicket())
            ],
          )),
    );
  }

  Widget renderTitleSection(Size _screenSize, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Menu Utama',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          TextButton(
              child: Row(
                children: [
                  Text('Log out', style: TextStyle(color: Colors.black87)),
                  const SizedBox(width: 6),
                  Icon(Icons.logout, color: Colors.black87)
                ],
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())))
        ],
      ),
    );
  }
}
