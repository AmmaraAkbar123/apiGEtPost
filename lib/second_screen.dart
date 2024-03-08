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
      appBar: AppBar(title: Text("My Store",style: TextStyle(fontWeight: FontWeight.w500),),
      centerTitle: true,
      ),
      body: Consumer<MyProviderAPI>(
        builder: (context, myproviderapi,child) {
         if(myproviderapi.isLoading){
            return
            Center(child: CircularProgressIndicator(),);
          }else if(myproviderapi.productList.isEmpty ){
            return Center(
              child: Text("No data is Available"),
            );
          }
          else{
            return ListView.builder(
            itemCount: myproviderapi.productList.length,
            itemBuilder: (context,index){
              final product= myproviderapi.productList[index];
              return Container(
                child: Column(
                  children: [
                    Text(product.title),
                    Text(product.description)
                  ],
                ),
              );
      
          });
          }
        }
      ),
    );
  }
}