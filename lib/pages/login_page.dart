import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ticket_app/data/user_data.dart' as dataUser;

import 'package:ticket_app/pages/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 720) {
            return LoginPagePC();
          }
          return LoginPageMobile();
        },
      ),
    );
  }
}

class LoginPageMobile extends StatelessWidget {
  const LoginPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        renderBackground(),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Evnt.in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                    Text('Penyedia event dan tiket terpercaya',
                        style: TextStyle(fontSize: 14, color: Colors.white70))
                  ],
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: TitleSection(
                      fontSize: 32,
                    )),
                LoginInput(),
                const SizedBox(
                  height: 8,
                ),
                Text('Ayo bergabung dan ikuti event menarik kami',
                    style: TextStyle(fontSize: 14, color: Colors.black54))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget renderBackground() {
    var radius = Radius.circular(70);
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff007E80),
                  borderRadius: BorderRadius.only(
                      bottomLeft: radius, bottomRight: radius)),
            )),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
            ))
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key? key,
    this.fontSize,
  }) : super(key: key);
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text('Daftarkan Dirimu',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }
}

class LoginPagePC extends StatelessWidget {
  const LoginPagePC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[renderBackgroundScreenPC(context)],
    );
  }

  Widget renderBackgroundScreenPC(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle _defaultStyle =
        TextStyle(fontSize: 18, color: Colors.white70);
    return SingleChildScrollView(
      child: Row(children: <Widget>[
        Expanded(
          flex: screenSize.width > 720 && screenSize.width < 850 ? 2 : 1,
          child: Container(
            height: screenSize.height,
            color: const Color(0xff007E80),
            child: LayoutBuilder(
              builder: (_, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text('Evnt.in', style: _defaultStyle),
                            const SizedBox(
                              height: 25,
                            ),
                            TitleSection(
                              fontSize: 32,
                            ),
                            Text('Ayo bergabung dan ikuti event menarik kami',
                                style: _defaultStyle),
                          ],
                        ),
                        Image.asset('assets/icons8_ticket_120px.png'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Evnt.in',
                                style: _defaultStyle.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amberAccent)),
                            Text('Penyedia event dan tiket terpercaya',
                                style: _defaultStyle),
                            const SizedBox(
                              height: 55,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
              color: Colors.white, child: Center(child: LoginInput())),
        )
      ]),
    );
  }
}

class LoginInput extends StatefulWidget {
  LoginInput({Key? key}) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 360),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //card n button
        children: <Widget>[
          inputLogin(),
          const SizedBox(
            height: 15,
          ),
          renderButton()
        ],
      ),
    );
  }

  Widget renderButton() {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith((states) =>
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Color(0xff007E80)),
            padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.symmetric(vertical: 15)),
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => Size.fromWidth(360))),
        onPressed: () {
          setState(() {
            dataUser.userCentralData.name = _usernameController.text;
            dataUser.userCentralData.myTickets!.length = 0;
            dataUser.userCentralData.saldo = 0;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        },
        child: Text(
          'Masuk',
          style: TextStyle(fontSize: 18),
        ));
  }

  Widget inputLogin() {
    // final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 320,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Color(0xffCCEEDD),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Login Akun',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xff003E3F)),
              ),
              SizedBox(height: 20),
              inputUser()
            ],
          ),
        ),
      ),
    );
  }

  Widget inputUser() {
    return Form(
      child: Column(children: <Widget>[
        TextFormField(
          onChanged: (value) {
            setState(() {
              dataUser.userCentralData.name = value;
            });
          },
          controller: _usernameController,
          decoration:
              InputDecoration(hintText: 'Username', labelText: 'Username'),
        ),
        const SizedBox(height: 15),
        TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
            ],
            onChanged: (value) {
              setState(() {
                dataUser.userCentralData.telpNumber = value;
              });
            },
            decoration: InputDecoration(
                hintText: 'No. Telpon', labelText: 'No. Telpon'))
      ]),
    );
  }
}

// class UserWidget extends InheritedWidget {
//   UserWidget({Key? key, required this.child, this.user})
//       : super(key: key, child: child);

//   final Widget child;
//   final UserModel? user;

//   static UserWidget? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<UserWidget>();
//   }

//   @override
//   bool updateShouldNotify(UserWidget oldWidget) {
//     return true;
//   }
// }
