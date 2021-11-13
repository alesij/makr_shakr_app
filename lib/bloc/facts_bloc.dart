import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:makr_shakr_app/model/facts_response.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'facts_event.dart';
part 'facts_state.dart';

class FactsBloc extends Bloc<FactsEvent, FactsState> {
  FactsBloc() : super(FactsInitial()) {
    on<FactsEvent>((event, emit) async {
      try{
        if(event is GetFacts){
          emit(FactsLoading());

          var request = http.Request('GET',
              Uri.parse('https://catfact.ninja/facts'));


          http.StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            Map<String, dynamic> json =
            jsonDecode(await response.stream.bytesToString());
            FactsResponse _factsResponse = FactsResponse.fromJson(json);
            emit(FactsSucceed(data: _factsResponse.data));
          } else {
            emit(FactsFailure(message: "Impossibile caricare i dati"));
          }
        }
      }catch(e) {
        emit(FactsFailure(message: "Impossibile caricare i dati, assicurati di essere connesso ad "
            "internet"));
      }
    });
  }
}
