import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nexus/Models/SearchMessage.dart';

import '../Data/Search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchSuccessState(messages: [])) {
    on<SearchGenerateNewTextMessageEvent>(searchGenerateNewTextMessageEvent);
  }
  List<SearchMessage> messages = [];
  bool generating = false;

  Future<FutureOr<void>> searchGenerateNewTextMessageEvent(
      SearchGenerateNewTextMessageEvent event,
      Emitter<SearchState> emit) async {
    messages.add(SearchMessage(
        role: "user", parts: [SearchPart(text: event.inputMessage)]));
    emit(SearchSuccessState(messages: messages));
    generating = true;
    String generatedText = await SearchData.searchTextGenerationRepo(messages);

    if (generatedText.length > 0) {
      messages.add(SearchMessage(
          role: "model", parts: [SearchPart(text: generatedText)]));
      emit(SearchSuccessState(messages: messages));
    }
    generating = false;
  }
}
