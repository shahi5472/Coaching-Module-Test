import 'package:equatable/equatable.dart';

class MetaModel extends Equatable {
  final String first;
  final String last;
  final String prev;
  final String next;

  const MetaModel({
    this.first = "",
    this.last = "",
    this.prev = "",
    this.next = "",
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      first: json['first'] ?? '',
      last: json['last'] ?? '',
      prev: json['prev'] ?? '',
      next: json['next'] ?? '',
    );
  }

  factory MetaModel.empty() => const MetaModel();

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }

  @override
  List<Object?> get props => [first, last, prev, next];
}
