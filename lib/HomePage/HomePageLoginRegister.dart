import 'package:flutter/material.dart';

class HomePageLoginRegister extends StatefulWidget {
  const HomePageLoginRegister({Key? key}) : super(key: key);

  @override
  State<HomePageLoginRegister> createState() => _HomePageLoginRegisterState();
}

class _HomePageLoginRegisterState extends State<HomePageLoginRegister>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.06,
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Text(
              "REGISTER",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900),
            ),
          ],
          indicator: const BoxDecoration(
            color: Colors.white,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: TabBarView(controller: _tabController, children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: const Color.fromRGBO(255, 255, 255, 100),//const Color.fromRGBO(196, 196, 196, 100),//const Color.fromRGBO(244, 230, 230, 100),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child:  const TextField(

                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.account_circle, size: 40,color: Colors.black,),
                        hintText: "Username", hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: const Color.fromRGBO(255, 255, 255, 100),//const Color.fromRGBO(196, 196, 196, 100),//const Color.fromRGBO(244, 230, 230, 100),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child:  const TextField(
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.lock, size: 40,color: Colors.black,),
                        hintText: "Password", hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: const Color.fromRGBO(255, 255, 255, 100),//const Color.fromRGBO(196, 196, 196, 100),//const Color.fromRGBO(244, 230, 230, 100),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child:  const TextField(

                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.account_circle, size: 40,color: Colors.black,),
                        hintText: "Username", hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: const Color.fromRGBO(255, 255, 255, 100),//const Color.fromRGBO(196, 196, 196, 100),//const Color.fromRGBO(244, 230, 230, 100),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child:  const TextField(
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.lock, size: 40,color: Colors.black,),
                        hintText: "Password", hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.5,
          child: TextButton(
              onPressed: () {
              },
              child: Text(
                "Continue",
                style: Theme.of(context).textTheme.button,
              )),
        )
      ],
    );
  }
}
