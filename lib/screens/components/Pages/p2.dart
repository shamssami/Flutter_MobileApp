import 'package:flutter/material.dart';
import 'package:task/screens/components/Pages/ATM.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  BoxDecoration deco1 = BoxDecoration(
      border: Border(
    bottom: BorderSide(color: Colors.black, width: 5),
  ));
  BoxDecoration deco2 = BoxDecoration(
      border: Border(
    bottom: BorderSide(color: Colors.black, width: 5),
  ));
  BoxDecoration deco3 = BoxDecoration(
      border: Border(
    bottom: BorderSide(color: Colors.black, width: 5),
  ));
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: deco1,
            // padding: EdgeInsets.all(10),
            child: TextButton(
              // style: TextButton.styleFrom(
              //   side: BorderSide(width: 3.0, color: Colors.green),
              // ),
              // style: ButtonStyle(
              //   fixedSize: MaterialStateProperty.all<Size>(Size(95, 40)),
              //   backgroundColor: MaterialStateProperty.all<Color>(
              //       Color.fromARGB(255, 0, 136, 41)),

              // ),

              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
              onPressed: () {
                setState(() {
                  deco1 = BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.red, width: 5),
                  ));
                });
                print('Helllllllloooooooo');
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: deco2
            //BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(30),
            //   ),
            //   boxShadow: [
            //     BoxShadow(
            //       offset: Offset(0, 0.5),
            //       blurRadius: 1,
            //       color: Colors.black.withOpacity(0.2),
            //     ),
            //   ],
            // ),
            // padding: EdgeInsets.all(10),
            ,
            child: TextButton(
              // style: ButtonStyle(
              //   fixedSize: MaterialStateProperty.all<Size>(Size(95, 40)),
              //   backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              // ),
              child: Text(
                'Call',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 136, 41), fontSize: 12),
              ),
              onPressed: () {
                setState(() {
                  deco2 = BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.red, width: 5),
                  ));
                });
                print('2222Helllllllloooooooo');
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: deco3,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(30),
            //   ),
            //   boxShadow: [
            //     BoxShadow(
            //       offset: Offset(0, 0.5),
            //       blurRadius: 1,
            //       color: Colors.black.withOpacity(0.2),
            //     ),
            //   ],
            // ),
            // padding: EdgeInsets.all(10),
            child: TextButton(
              // style: ButtonStyle(
              //   fixedSize: MaterialStateProperty.all<Size>(Size(95, 40)),
              //   backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              // ),
              child: Text(
                'Call',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 136, 41), fontSize: 12),
              ),
              onPressed: () {
                setState(() {
                  deco3 = BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.red, width: 5),
                  ));
                });
                print('2222Helllllllloooooooo');
              },
            ),
          ),
        )
      ],
    ));
  }
}
