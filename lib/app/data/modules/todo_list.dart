import 'package:equatable/equatable.dart';

//TODO: Rename this to ListItem, list_item
class TodoList extends Equatable {
  final String title;
  final List<dynamic>? listItems;

  const TodoList({
    required this.title,
    this.listItems,
  });

  TodoList copyWith({
    String? title,
    List<dynamic>? listItems,
  }) {
    return TodoList(
      title: title ?? this.title,
      listItems: listItems ?? this.listItems,
    );
  }

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      title: json['title'],
      listItems: json['listItems'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'listItems': listItems,
  };

  @override
  List<Object?> get props => [title];
}
