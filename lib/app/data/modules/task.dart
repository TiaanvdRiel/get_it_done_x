import 'package:equatable/equatable.dart';

//TODO: Rename this to ListItem, list_item
//also remove icon and color... okay maybe no just to "list" and then todos can be list items
class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todos, //Nullable for empty lists
  });

  Task copyWith({
    String? color,
    String? title,
    int? icon,
    List<dynamic>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      todos: todos ?? this.todos,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      todos: json['todos'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'icon': icon,
    'color': color,
    'todos': todos,
  };

  @override
  List<Object?> get props => [title, icon, color];
}
