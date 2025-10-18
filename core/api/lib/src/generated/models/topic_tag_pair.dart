// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_tag_pair.freezed.dart';
part 'topic_tag_pair.g.dart';

@Freezed()
abstract class TopicTagPair with _$TopicTagPair {
  const factory TopicTagPair({
    /// Название темы
    required String topic,

    /// Название тега
    required String tag,
  }) = _TopicTagPair;
  
  factory TopicTagPair.fromJson(Map<String, Object?> json) => _$TopicTagPairFromJson(json);
}
