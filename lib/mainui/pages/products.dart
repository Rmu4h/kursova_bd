import 'package:flutter/material.dart';
import 'package:kursova_bd/logic/classes.dart';
import '../../authentication/login-page.dart';
import '../../logic/processing.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


class ProductPage extends StatefulWidget {
  final User currentuser;
  const ProductPage({super.key, required this.currentuser});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late int counter;
  late final Future myFuture;
  List namesProducts = [];
  String searchString = "";
  final searchController = TextEditingController();
  final nameRegExp = RegExp(r'^(?=.*?[a-z]).{3,}$');
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  static const List<String> _madeNumber = <String>['1', '2', '3', '4'];
  late String _dropdownValue;

  @override
  void initState() {

    _dropdownValue = _madeNumber.first;

    super.initState();

    myFuture = downloadList();
    // namesProducts = namesProducts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        body: Stack(
      children: [
        Center(
            child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFA2A6B1),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/");
                  },
                ),
              ],
            ),
            // buildSearch(),
            Container(
              height: 42,
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  // border: Border.all(color: Colors.black26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                controller: searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'SEARCH PRODUCT NAME',
                  border: InputBorder.none,

                  // contentPadding: EdgeInsets.only(bottom: 0.0), //here
                ),
              ),
            ),
            FutureBuilder(
                future: myFuture, //це у нас _initPhotosData
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  print(snapshot.connectionState);

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
                      // lengthList = namesProducts.length;

                      return Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: RefreshIndicator(
                            key: _refreshIndicatorKey,
                            onRefresh: refresh,
                            child: ListView.separated(
                                padding: const EdgeInsets.all(8),
                                itemCount: namesProducts.length,
                                // замінив з snapshot.data
                                itemBuilder: (BuildContext context, int index) {
                                  // print(namesProducts[index].name);
                                  return namesProducts[index]
                                          .name
                                          .contains(searchString)
                                      ? Dismissible(
                                          background: Container(
                                            color: Colors.red,
                                          ),
                                          key: ValueKey(namesProducts[index]),
                                          // замінив з snapshot.data
                                          onDismissed:
                                              (DismissDirection direction) {
                                            print(snapshot.data[index]);
                                            Processing.deleteProduct(namesProducts[
                                                    index]
                                                .productId); // замінив з snapshot.data

                                            setState(() {
                                              namesProducts.removeAt(
                                                  index); // замінив з snapshot.data
                                            });
                                          },
                                          child: Container(
                                              // height: 30,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF6040E5),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  ListTile(
                                                    leading: Image.asset(
                                                      'assets/images/food.png',
                                                      fit: BoxFit.cover,
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    title: Column(
                                                      children: [
                                                        Text(
                                                          '${namesProducts[index].name}',
                                                          // замінив з snapshot.data
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${namesProducts[index].amount} - Items',
                                                          // замінив з snapshot.data
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Text(
                                                      '\$${namesProducts[index].price}',
                                                      // замінив з snapshot.data
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              FloatingActionButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                namesProducts[
                                                                        index]
                                                                    .amount += 1;
                                                              });
                                                              //функція яка обновляє амоинт
                                                              Processing.updateProduct(
                                                                  namesProducts[
                                                                      index]); // замінив з snapshot.data
                                                            },
                                                            tooltip:
                                                                'Increment',
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              FloatingActionButton(
                                                            onPressed: () {
                                                              if (namesProducts[
                                                                          index]
                                                                      .amount > // замінив з snapshot.data
                                                                  1) {
                                                                setState(() {
                                                                  namesProducts[
                                                                          index] // замінив з snapshot.data
                                                                      .amount -= 1;
                                                                  // namesProducts[index]    // замінив з snapshot.data
                                                                  //     .price -= 1000;
                                                                });
                                                                //функція яка обновляє амоинт
                                                                Processing.updateProduct(
                                                                    namesProducts[
                                                                        index]); // замінив з snapshot.data
                                                              }
                                                            },
                                                            tooltip:
                                                                'Decrement',
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                      : Container();
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    // height: 1,
                                    thickness: 1,
                                    // indent: 20,
                                    endIndent: 0,
                                    color: Colors.black,
                                  );
                                })),
                      );
                    }

                    return const Text('Empty data');
                  }
                  return const Text('Empty data2');
                  // return const Text('Reload');
                }),
          ],
        )),
        Positioned(
          right: 30.0,
          bottom: 30.0,
          child: FloatingActionButton(
            onPressed: () {
              final TextEditingController _name = TextEditingController();
              final TextEditingController _dateOfReceipt =
                  TextEditingController(text: '2022-11-29');
              final TextEditingController _expirationDate =
                  TextEditingController();
              final TextEditingController _amount = TextEditingController();
              final TextEditingController _price = TextEditingController();
              final TextEditingController _made_of =
                  TextEditingController(text: '');
              final TextEditingController _ownerId = TextEditingController();
              TextEditingController dateinput = TextEditingController();


              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                builder: (_) {
                  // String _dropdownValue = _madeNumber.first;
                  print('new in showModalBottomSheet');

                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        print('new in StatefulBuilder window');

                        return Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Scaffold(
                            resizeToAvoidBottomInset: true,
                            body: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Color(0xFFA2A6B1),
                                      ),
                                    ),
                                  ],
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Add new product',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          // height: 5,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CustomFormField(
                                        hintText: "Enter product name",
                                        controller: _name,
                                        validator: (val) {
                                          if (!nameRegExp.hasMatch(val!))
                                            return 'Enter valid name';
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _dateOfReceipt,
                                        //editing controller of this TextField
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.calendar_today),
                                            //icon of text field
                                            labelText:
                                            "Enter product date of receipt" //label text of field
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
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {
                                              _dateOfReceipt.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _expirationDate,
                                        //editing controller of this TextField
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.calendar_today),
                                            //icon of text field
                                            labelText:
                                            "Enter product expiration date" //label text of field
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
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {
                                              _expirationDate.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      CustomFormField(
                                        hintText: 'Amount',
                                        controller: _amount,
                                        validator: (val) {
                                          final amountRegExp = RegExp(r'^[0-9]+$');

                                          if (!amountRegExp.hasMatch(val!)) {
                                            return 'Enter valid Amount';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      CustomFormField(
                                        hintText: 'Price',
                                        controller: _price,
                                        validator: (val) {
                                          final phoneRegExp = RegExp(r'^[0-9]+$');

                                          if (!phoneRegExp.hasMatch(val!)) {
                                            return 'Enter valid Price';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Enter valid made_of'),
                                          DropdownButton<String>(
                                            value: _dropdownValue,
                                            icon: const Icon(Icons.arrow_downward),
                                            elevation: 16,
                                            style:
                                            const TextStyle(color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              _dropdownValue = value!;

                                              setState(() {});
                                            },
                                            items: _madeNumber.map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      CustomFormField(
                                        hintText: 'owner_id',
                                        controller: _ownerId,
                                        validator: (val) {
                                          final numberRegExp = RegExp(r'^[0-9]+$');

                                          if (!numberRegExp.hasMatch(val!)) {
                                            return 'Enter valid owner_id';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF613CEA),
                                          // backgroundColor: const Color(0xFFA2A6B1),

                                          padding: const EdgeInsets.fromLTRB(
                                              40, 20, 40, 20),
                                        ),
                                        child: const Text('SAVE CHANGES'),
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            var newItem = Product(
                                                productId: 0,
                                                name: _name.text,
                                                dateOfReceipt: _dateOfReceipt.text,
                                                expirationDate: _expirationDate.text,
                                                amount: int.parse(_amount.text),
                                                price: double.parse(_price.text),
                                                madeOf: int.parse(_dropdownValue),
                                                ownerId: widget.currentuser.userId);

                                            Processing.putProduct(newItem);
                                            _refreshIndicatorKey.currentState?.show();
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
              );
            },
            tooltip: 'Add new item',
            backgroundColor: Colors.pink,
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    ));
  }

  Future refresh() async {
    final products = await Processing.getProducts(widget.currentuser.userId).then((value) {
      namesProducts = value;

      return namesProducts;
    });

    setState(() {
      namesProducts = products;
      // lengthList = products.length;
    });
    // return Future<void>.delayed(const Duration(seconds: 2));
  }

  //це у нас _initPhotos
  downloadList() {
    return Processing.getProducts(widget.currentuser.userId).then((value) {
      namesProducts = value;

      return namesProducts;
    });
  }
}
