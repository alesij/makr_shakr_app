
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makr_shakr_app/bloc/facts_bloc.dart';
import 'package:makr_shakr_app/model/facts_response.dart';
import 'package:makr_shakr_app/pages/tile_detail.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Datum> _data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocConsumer<FactsBloc, FactsState>(
            listener: (context, state) {
              if(state is FactsSucceed){
                _data = state.data;
                for(Datum data in _data){
                  data.img = 'http://placekitten.com/${data.length}/${data.length}';
                }
              }
              if(state is FactsFailure){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              ///LOADING
              if(state is FactsLoading){
                return const Center(child: CircularProgressIndicator());
              }
              ///GET SUCCEED
              else if (state is FactsSucceed) {
                return Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: _data.length,
                      itemBuilder: (context, index)
                      {
                        return ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(300.0),
                                child: Image.network(_data[index].img,
                                  fit: BoxFit.fill
                                )),

                            trailing: const Icon(Icons.arrow_forward_ios_outlined),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return TileDetail(dataDetail: _data[index]);
                                    }),
                              );
                            },
                            title: Text(
                              _data[index].fact,
                              overflow: TextOverflow.ellipsis,
                            ));
                      }),
                );
              }
              ///GET FAILURE
              return Center(child: ElevatedButton(
                child: Text("Riprova"),
                style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                       BorderRadius.circular(30.0),
                    )),

                onPressed: () => BlocProvider.of<FactsBloc>(context).add(GetFacts()),
              ));
            }
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}