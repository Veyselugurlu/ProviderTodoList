import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/proje/models/cat_fact_model.dart';

//istek attık bu linke
final httpClientProvider = Provider<Dio>((ref){
  return Dio(BaseOptions(baseUrl: 'https://catfact.ninja/'));
});

final catFactsProvider = FutureProvider<List<CatFactModel>>((ref) async {
    final _dio = ref.watch(httpClientProvider);
    final _result = await _dio.get('facts');
    List<Map<String, dynamic>> _mapData =List.from(_result.data['data']);
    List<CatFactModel> _catFactList = _mapData.map((e) => CatFactModel.fromMap(e)).toList();
    return _catFactList ;
});
class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key : key);
@override
Widget build (BuildContext context , WidgetRef ref){
  var _liste = ref.watch(catFactsProvider);
  return Scaffold(
    body: SafeArea(
      child: _liste.when(data: (liste){
        return ListView.builder(
          itemCount: liste.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(liste[index].fact ?? " "),
            );
          },
        );
      }, 
      error: (err,stack){
        return Center(child: Text("hata cikti $err.toString()"),);
      }, 
      loading: () => Center(child: CircularProgressIndicator(),),),
    ),
  );
}

}