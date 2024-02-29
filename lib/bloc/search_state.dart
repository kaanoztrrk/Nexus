part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<SearchMessage> messages;

  SearchSuccessState({required this.messages});
}
