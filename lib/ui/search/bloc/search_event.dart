part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchQuotesEvent extends SearchEvent {
  final String query;
  final int page;
  final String type;
  SearchQuotesEvent({
    required this.query,
    required this.page,
    required this.type,
  });
}
final class ClearSearchErrorEvent extends SearchEvent {
  ClearSearchErrorEvent();
}
