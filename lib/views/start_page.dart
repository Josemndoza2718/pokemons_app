import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartPage extends StatefulWidget {
   StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>  with TickerProviderStateMixin  {

  @override
  void dispose() {
    _controller1.dispose();
    // _controller2.dispose();
    // _controller3.dispose();
    super.dispose();
  }


   late final AnimationController _controller1 = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _offsetAnimation1 = Tween<double>(
    begin: 1,
    end: 1.1,
  ).animate(CurvedAnimation(
    parent: _controller1,
    curve: Curves.elasticInOut,
  ));

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc5232c),
        centerTitle: true,
        toolbarHeight: 100,
        title: const Column(
          children: [
            Text(
              "Welcome to",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "PokeDex",
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffc5232c),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center, 
            children: [
            Image.asset("assets/png/ash_ketchum.png"),
            Positioned(
              left: 30,
              bottom: 125,
              child: GestureDetector(
                onTap: () {
                  context.push('/menuPage');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _offsetAnimation1,
                      child: Image.asset(
                        "assets/gif/pokemon_master_ball.gif",
                        width: 220,
                        height: 220,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

}