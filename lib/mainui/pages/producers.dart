import 'package:flutter/material.dart';

class ProducerPage extends StatelessWidget {
  const ProducerPage({super.key});

  @override
  Widget build(BuildContext context) {
    List arr = ['one', 'two', 'three'];

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFFA2A6B1),
                ),
                onPressed: () {
                  print('sent');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const LoginPage()));
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (r) => false);
                },
              ),
            ],
          ),
            Text('${arr[0]}'),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // height: 30,
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(' ${arr[index]}',
                              // textAlign: TextAlign.center,
                              style: const TextStyle(
                                // color: Color(0xFF613CEA),
                              )),
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  // height: 1,
                  thickness: 1,
                  // indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
              )),
        ],
      )),
    );
  }
}
