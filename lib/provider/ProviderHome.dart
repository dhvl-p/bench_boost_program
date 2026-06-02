import 'package:bench_boost_program/provider/provider/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ProviderHone extends StatefulWidget {
  const ProviderHone({super.key});

  @override
  State<ProviderHone> createState() => _ProviderHoneState();
}

class _ProviderHoneState extends State<ProviderHone> {
  @override
  initState() {
    super.initState();
     Provider.of<DataProvider>(context, listen: false).getPostData(context);
  }
  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('provider_app_bar_title'.tr), leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Get.back(), // Manual back action
      ),),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: postMdl.loading
            ? Center(
                child: const CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      postMdl.data.name ?? "",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Text(
                    postMdl.data.body ?? "",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
      )
    );
  }
}
