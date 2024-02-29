part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchGenerateNewTextMessageEvent extends SearchEvent {
  final String inputMessage;

  SearchGenerateNewTextMessageEvent({required this.inputMessage});
}
