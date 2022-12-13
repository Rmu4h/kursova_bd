import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kursova_bd/logic/classes.dart';
import '../../logic/processing.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  final User currentuser;

  const ReportPage({super.key, required this.currentuser});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List namesProducts = [];
  late final Future myFuture;
  final TextEditingController _dateOfReceipt =
      TextEditingController(text: '2020-11-29');
  final TextEditingController _expirationDate = TextEditingController(text: '2032-11-29');
  late var fromDate = DateTime.parse(_dateOfReceipt.text);
  late var toDate = DateTime.parse(_expirationDate.text);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    myFuture = downloadList();
    // namesProducts = namesProducts
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            const Text('ReportPage'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150.0,
                  child: TextField(
                    controller: _dateOfReceipt,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(
                            Icons.calendar_today,
                            color: Color(0xFF613CEA),
                        ),
                        //icon of text field
                        labelText: "From" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          _dateOfReceipt.text = formattedDate;
                          fromDate = DateTime.parse(formattedDate);//set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                      print('${fromDate} - fromDate');
                    },
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: TextField(
                    controller: _expirationDate,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(
                            Icons.calendar_today,
                            color: Color(0xFF613CEA),
                        ),
                        //icon of text field
                        labelText: "To" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          _expirationDate.text = formattedDate;
                          toDate = DateTime.parse(formattedDate);//set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                      print('${toDate} - toDate');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              border: TableBorder.symmetric(
                  inside: const BorderSide(width: 2, color: Colors.black)
              ),
              // border: const TableBorder(
              //     horizontalInside: BorderSide(width: 2),
              // ),

              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: const [
                TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xFF6040E5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)
                      ),
                    ),
                    children: [
                  Text(
                    'name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                    ),
                  ),
                  Text(
                      'amount',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                      'price',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                      'dateOfReceipt',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                      'expirationDate',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                      'madeOf',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ]),
              ],
            ),
            FutureBuilder(
                future: myFuture,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitThreeBounce(
                      color: Color(0xFF6040E5),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    }
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      print(namesProducts.length);

                      return RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: refresh,
                        child: ListView.builder(
                            shrinkWrap: true,
                            // padding: const EdgeInsets.all(8),
                            itemCount: namesProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return createTable(namesProducts.length, index);
                            }
                        ),
                      );
                    }
                  }
                  return const Text('Empty table');
                })
          ],
        ),
      ),
    );
  }

  downloadList() {
    return Processing.getProducts(widget.currentuser.userId).then((value) {
      namesProducts = value;

      return namesProducts;
    });
  }

  Future refresh() async {
    final products = await Processing.getProducts(widget.currentuser.userId).then((value) {
      namesProducts = value;

      return namesProducts;
    });

    setState(() {
      namesProducts = products;
    });
    // return Future<void>.delayed(const Duration(seconds: 2));
  }

  Widget createTable(lengthTable, index) {
    List<TableRow> rows = [];

    for (int i = 1; i < lengthTable; i++) {
      var itemFromDate = DateTime.parse(namesProducts[index].dateOfReceipt);
      var itemToDate = DateTime.parse(namesProducts[index].expirationDate);

      if(itemFromDate.isAfter(fromDate) && itemToDate.isBefore(toDate)){
        rows.add(TableRow(children: [
          Text(
            namesProducts[index].name,
            textAlign: TextAlign.center,
          ),
          Text(
            '${namesProducts[index].amount}',
            textAlign: TextAlign.center,
          ),
          Text(
              '${namesProducts[index].price}',
              textAlign: TextAlign.center,
          ),
          Text(
              '${namesProducts[index].dateOfReceipt}',
              textAlign: TextAlign.center,
          ),
          Text(
              '${namesProducts[index].expirationDate}',
              textAlign: TextAlign.center,
          ),
          Text(
              '${namesProducts[index].madeOf}',
              textAlign: TextAlign.center,
          ),
        ]));
      }
    }
    return Table(
        border: TableBorder.all(),
        children: rows,
    );
  }
}
