import 'package:flutter/material.dart';
import '../../authentication/login-page.dart';
import '../../logic/processing.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late int counter;
  late final Future myFuture;

  // int lengthList = 0;

  int counter2 = 0;
  List namesProducts = [];

  // String query = '';
  String searchString = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myFuture = downloadList();
    // namesProducts = namesProducts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (r) => false);
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
                        // print('1');

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          print('wait');
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
                                  onRefresh: refresh,
                                  child: ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: namesProducts.length,
                                      // замінив з snapshot.data
                                      itemBuilder: (BuildContext context, int index) {
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
                                              padding: const EdgeInsets.all(10.0),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF6040E5),
                                                  borderRadius: BorderRadius.all(
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
                                                          style: const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${namesProducts[index].amount} - Items',
                                                          // замінив з snapshot.data
                                                          textAlign:
                                                          TextAlign.center,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Text(
                                                      '\$${namesProducts[index].price * namesProducts[index].amount}',
                                                      // замінив з snapshot.data
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    // tileColor: const Color(0xFF6040E5),
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
                                                                index] // замінив з snapshot.data
                                                                    .amount += 1;
                                                                // namesProducts[index]  // замінив з snapshot.data
                                                                //     .price += 1000;
                                                              });
                                                              //функція яка обновляє амоинт
                                                              Processing.updateProduct(
                                                                  namesProducts[
                                                                  index]); // замінив з snapshot.data
                                                            },
                                                            tooltip: 'Increment',
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: Colors.white,
                                                              size: 20.0,
                                                            ),
                                                          ),
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
                                                            tooltip: 'Decrement',
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color: Colors.white,
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
                                          // // height: 1,
                                          // thickness: 1,
                                          // // indent: 20,
                                          // endIndent: 0,
                                          // color: Colors.black,
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
              onPressed: () {},
              tooltip: 'Add new item',
              backgroundColor: Colors.pink,
              child: const Icon(
                  Icons.add,
              ),
            ),
          ),
        ],
      )
    );
  }

  Future refresh() async {
    final products = await Processing.getProducts(22).then((value) {
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
    return Processing.getProducts(22).then((value) {
      namesProducts = value;

      return namesProducts;
    });
  }

// Widget buildSearch() =>
//     SearchWidget(
//       text: query,
//       hintText: 'Name or Price Name',
//       onChanged: searchBook,
//     );
//
// void searchBook(String query) {
//   final product = namesProducts.where((book) {
//     final titleLower = book.name.toLowerCase();
//     final priceLower = book.price.toLowerCase();
//     final searchLower = query.toLowerCase();
//
//     return titleLower.contains(searchLower) ||
//         priceLower.contains(searchLower);
//   }).toList();
//
//   setState(() {
//     this.query = query;
//     this.namesProducts = product;
//   });
// }

}
