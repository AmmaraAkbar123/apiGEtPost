import 'package:apigetpractice/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        context.read<MyProviderAPI>().getApiList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Store",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Consumer<MyProviderAPI>(builder: (context, myproviderapi, child) {
        if (myproviderapi.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (myproviderapi.productList.isEmpty) {
          return const Center(
            child: Text("No data is Available"),
          );
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: myproviderapi.productList.length,
            itemBuilder: (context, index) {
              final product = myproviderapi.productList[index];
              return GridTile(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: Column(children: [
                      Expanded(
                        child: Image.network(product.thumbnail),
                        //     child: CarouselSlider(
                        //   items: product.images
                        //       .map((e) => Container(
                        //             child: Image.network(e),
                        //           ))
                        //       .toList(),
                        //   options: CarouselOptions(
                        //     aspectRatio: 2.0,
                        //   ),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 8, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.description,
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              product.brand,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              product.discountPercentage.toString(),
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ])),
              );
            },
          );
        }
      }),
    );
  }
}
