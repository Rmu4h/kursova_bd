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
  late final Future myFutureProducersList;
  List namesProducts = [];
  List namesProducers = [];

  String searchString = "";
  final searchController = TextEditingController();
  final nameRegExp = RegExp(r'^(?=.*?[a-z]).{3,}$');
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // static const List<String> _madeNumber = <String>['1', '2', '3', '4'];
  // late String _dropdownValue;

  @override
  void initState() {
    // _dropdownValue = _madeNumber.first;

    super.initState();

    myFuture = downloadList();
    myFutureProducersList = downloadProducers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Center(
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SpinKitThreeBounce(
                              color: Color(0xFF6040E5),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            }
                            if (snapshot.hasData && snapshot.data.length > 0) {
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return namesProducts[index]
                                                  .name
                                                  .contains(searchString)
                                              ? Dismissible(
                                                  background: Container(
                                                    color: Colors.red,
                                                  ),
                                                  key: ValueKey(
                                                      namesProducts[index]),
                                                  onDismissed: (DismissDirection
                                                      direction) {
                                                    Processing.deleteProduct(
                                                        namesProducts[index]
                                                            .productId); // замінив з snapshot.data

                                                    setState(() {
                                                      namesProducts.removeAt(
                                                          index); // замінив з snapshot.data
                                                    });
                                                  },
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              Color(0xFF6040E5),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .center,
                                                        children: [
                                                          ListTile(
                                                            leading:
                                                                Image.asset(
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
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${namesProducts[index].amount} - Items',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            subtitle: Text(
                                                              '\$${namesProducts[index].price}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            trailing: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child:
                                                                      FloatingActionButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        namesProducts[index]
                                                                            .amount += 1;
                                                                      });
                                                                      //функція яка обновляє амоинт
                                                                      Processing
                                                                          .updateProduct(
                                                                              namesProducts[index]); // замінив з snapshot.data
                                                                    },
                                                                    tooltip:
                                                                        'Increment',
                                                                    child:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          20.0,
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
                                                                    onPressed:
                                                                        () {
                                                                      if (namesProducts[index]
                                                                              .amount >
                                                                          1) {
                                                                        setState(
                                                                            () {
                                                                          namesProducts[index].amount -=
                                                                              1;
                                                                        });
                                                                        //функція яка обновляє амоинт
                                                                        Processing.updateProduct(
                                                                            namesProducts[index]); // замінив з snapshot.data
                                                                      }
                                                                    },
                                                                    tooltip:
                                                                        'Decrement',
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            onTap: () =>
                                                                dialogBuilderEditProduct(
                                                                    context,
                                                                    namesProducts[
                                                                        index]),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                              : Container();
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider(
                                            thickness: 1,
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
                      final TextEditingController name =
                          TextEditingController();
                      final TextEditingController dateOfReceipt =
                          TextEditingController(text: '2022-11-29');
                      final TextEditingController expirationDate =
                          TextEditingController();
                      final TextEditingController amount =
                          TextEditingController();
                      final TextEditingController price =
                          TextEditingController();
                      late Producer dropProducerNamesAdd;
                      late int dropProducerIdAdd;

                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        builder: (_) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: Scaffold(
                                resizeToAvoidBottomInset: true,
                                body: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          const Text(
                                            'Add new product',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          CustomFormField(
                                            hintText: "Enter product name",
                                            controller: name,
                                            validator: (val) {
                                              if (!nameRegExp.hasMatch(val!)) {
                                                return 'Enter valid name';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller: dateOfReceipt,
                                            //editing controller of this TextField
                                            decoration: const InputDecoration(
                                                icon:
                                                    Icon(Icons.calendar_today),
                                                labelText:
                                                    "Enter product date of receipt" //label text of field
                                                ),
                                            readOnly: true,
                                            //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
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
                                                  dateOfReceipt.text =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller: expirationDate,
                                            //editing controller of this TextField
                                            decoration: const InputDecoration(
                                                icon:
                                                    Icon(Icons.calendar_today),
                                                //icon of text field
                                                labelText:
                                                    "Enter product expiration date" //label text of field
                                                ),
                                            readOnly: true,
                                            //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
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
                                                  expirationDate.text =
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
                                            controller: amount,
                                            validator: (val) {
                                              final amountRegExp =
                                                  RegExp(r'^[0-9]+$');

                                              if (!amountRegExp
                                                  .hasMatch(val!)) {
                                                return 'Enter valid Amount';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          CustomFormField(
                                            hintText: 'Price',
                                            controller: price,
                                            validator: (val) {
                                              final phoneRegExp =
                                                  RegExp(r'^[0-9]+$');

                                              if (!phoneRegExp.hasMatch(val!)) {
                                                return 'Enter valid Price';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Enter valid made_of'),
                                              const SizedBox(width: 60),
                                              FutureBuilder(
                                                  future: myFutureProducersList,
                                                  builder: (context,
                                                      AsyncSnapshot<dynamic>
                                                          snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      if (snapshot.hasError) {
                                                        return const Text(
                                                            'Error');
                                                      }

                                                      if (snapshot.hasData) {
                                                        dropProducerNamesAdd =
                                                            namesProducers[0];
                                                        dropProducerIdAdd =
                                                            namesProducers[0]
                                                                .producerId;

                                                        return (!namesProducers[
                                                                    0]
                                                                .name
                                                                .isEmpty)
                                                            ? Expanded(
                                                                child: StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return DropdownButton(
                                                                    value:
                                                                        dropProducerNamesAdd,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .arrow_downward),
                                                                    elevation:
                                                                        16,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .deepPurple),
                                                                    underline:
                                                                        Container(
                                                                      height: 2,
                                                                      color: Colors
                                                                          .deepPurpleAccent,
                                                                    ),
                                                                    onChanged:
                                                                        (value) {
                                                                      // This is called when the user selects an item.
                                                                      dropProducerNamesAdd =
                                                                          value;
                                                                      dropProducerIdAdd =
                                                                          value!
                                                                              .producerId;

                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    items: namesProducers
                                                                        .map<DropdownMenuItem>(
                                                                            (value) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value.name),
                                                                      );
                                                                    }).toList(),
                                                                  );
                                                                }),
                                                              )
                                                            : const Text('emp');
                                                      }
                                                    }
                                                    return const Text(
                                                        'Empty dropdown');
                                                  }),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF613CEA),
                                              // backgroundColor: const Color(0xFFA2A6B1),

                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      40, 20, 40, 20),
                                            ),
                                            child: const Text('SAVE CHANGES'),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                var newItem = Product(
                                                    productId: 0,
                                                    name: name.text,
                                                    dateOfReceipt:
                                                        dateOfReceipt.text,
                                                    expirationDate:
                                                        expirationDate.text,
                                                    amount:
                                                        int.parse(amount.text),
                                                    price: double.parse(
                                                        price.text),
                                                    madeOf: dropProducerIdAdd,
                                                    ownerId: widget
                                                        .currentuser.userId);

                                                Processing.putProduct(newItem);
                                                _refreshIndicatorKey
                                                    .currentState
                                                    ?.show();
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
                          });
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
            )));
  }

  Future refresh() async {
    final products =
        await Processing.getProducts(widget.currentuser.userId).then((value) {
      namesProducts = value;

      return namesProducts;
    });

    setState(() {
      namesProducts = products;
    });
  }

  downloadList() {
    return Processing.getProducts(widget.currentuser.userId).then((value) {
      namesProducts = value;

      return namesProducts;
    });
  }

  downloadProducers() {
    return Processing.getProducers().then((value) {
      namesProducers = value;

      return namesProducers;
    });
  }

  Future<void> dialogBuilderEditProduct(
      BuildContext context, Product editProductItem) {
    // final formKey = GlobalKey<FormState>();

    final TextEditingController name =
        TextEditingController(text: editProductItem.name);
    final TextEditingController dateOfReceipt =
        TextEditingController(text: editProductItem.dateOfReceipt);
    final TextEditingController expirationDate =
        TextEditingController(text: editProductItem.expirationDate);
    final TextEditingController amount =
        TextEditingController(text: editProductItem.amount.toString());
    final TextEditingController price =
        TextEditingController(text: editProductItem.price.toString());
    Producer dropProducerNames;
    late int dropProducerId;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var heightAlert = MediaQuery.of(context).size.height;

        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Center(
              child: SizedBox(
                height: heightAlert * 0.75,
                child: AlertDialog(
                    // insetPadding: EdgeInsets.symmetric(vertical: height),
                    title: const Text('Change product'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // const SizedBox(height: 10),
                          CustomFormField(
                            hintText: "Enter product name",
                            controller: name,
                            validator: (val) {
                              if (!nameRegExp.hasMatch(val!)) {
                                return 'Enter valid name';
                              }
                              return null;
                            },
                          ),
                          TextField(
                            controller: dateOfReceipt,
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
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateOfReceipt.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          TextField(
                            controller: expirationDate,
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
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  expirationDate.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          CustomFormField(
                            hintText: 'Amount',
                            controller: amount,
                            validator: (val) {
                              final amountRegExp = RegExp(r'^[0-9]+$');

                              if (!amountRegExp.hasMatch(val!)) {
                                return 'Enter valid Amount';
                              }
                              return null;
                            },
                          ),
                          CustomFormField(
                            hintText: 'Price',
                            controller: price,
                            validator: (val) {
                              final phoneRegExp = RegExp(r'^[0-9]+$');

                              if (!phoneRegExp.hasMatch(val!)) {
                                return 'Enter valid Price';
                              }
                              return null;
                            },
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Choose Producer name'),
                                FutureBuilder(
                                  future: myFutureProducersList,
                                  builder: (context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      }

                                      if (snapshot.hasData) {
                                        dropProducerNames = namesProducers[0];
                                        print(
                                            '${dropProducerNames.runtimeType} - type of dropProducerNames');
                                        dropProducerId =
                                            namesProducers[1].producerId;

                                        return (!namesProducers[0].name.isEmpty)
                                            ? Expanded(child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  return DropdownButton(
                                                    isExpanded: true,
                                                    value: dropProducerNames,
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                    ),
                                                    onChanged: (value) {
                                                      dropProducerNames = value;
                                                      dropProducerId =
                                                          value!.producerId;

                                                      setState(() {});
                                                    },
                                                    items: namesProducers
                                                        .map<DropdownMenuItem>(
                                                            (value) {
                                                      return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value.name),
                                                      );
                                                    }).toList(),
                                                  );
                                                },
                                              ))
                                            : const Text('emp');
                                      }
                                    }
                                    return const Text('Empty dropdown');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                ),
                                child: const Text('Save changes',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var updatedProduct = Product(
                                        productId: editProductItem.productId,
                                        name: name.text,
                                        dateOfReceipt: dateOfReceipt.text,
                                        expirationDate: expirationDate.text,
                                        amount: int.parse(amount.text),
                                        price: double.parse(price.text),
                                        madeOf: dropProducerId,
                                        ownerId: widget.currentuser.userId);

                                    Processing.updateProduct(updatedProduct);
                                    _refreshIndicatorKey.currentState?.show();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                ),
                                child: const Text('Close',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        });
      },
    );
  }
}
