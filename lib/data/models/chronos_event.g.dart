// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronos_event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChronosEventCollection on Isar {
  IsarCollection<ChronosEvent> get chronosEvents => this.collection();
}

const ChronosEventSchema = CollectionSchema(
  name: r'ChronosEvent',
  id: 3365092442945936317,
  properties: {
    r'importance': PropertySchema(
      id: 0,
      name: r'importance',
      type: IsarType.long,
    ),
    r'isFulfilled': PropertySchema(
      id: 1,
      name: r'isFulfilled',
      type: IsarType.bool,
    ),
    r'positiveHits': PropertySchema(
      id: 2,
      name: r'positiveHits',
      type: IsarType.long,
    ),
    r'query': PropertySchema(
      id: 3,
      name: r'query',
      type: IsarType.string,
    ),
    r'sigma': PropertySchema(
      id: 4,
      name: r'sigma',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 5,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'totalSamples': PropertySchema(
      id: 6,
      name: r'totalSamples',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.string,
      enumMap: _ChronosEventtypeEnumValueMap,
    )
  },
  estimateSize: _chronosEventEstimateSize,
  serialize: _chronosEventSerialize,
  deserialize: _chronosEventDeserialize,
  deserializeProp: _chronosEventDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _chronosEventGetId,
  getLinks: _chronosEventGetLinks,
  attach: _chronosEventAttach,
  version: '3.1.0+1',
);

int _chronosEventEstimateSize(
  ChronosEvent object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.query.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _chronosEventSerialize(
  ChronosEvent object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.importance);
  writer.writeBool(offsets[1], object.isFulfilled);
  writer.writeLong(offsets[2], object.positiveHits);
  writer.writeString(offsets[3], object.query);
  writer.writeDouble(offsets[4], object.sigma);
  writer.writeDateTime(offsets[5], object.timestamp);
  writer.writeLong(offsets[6], object.totalSamples);
  writer.writeString(offsets[7], object.type.name);
}

ChronosEvent _chronosEventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChronosEvent(
    importance: reader.readLong(offsets[0]),
    isFulfilled: reader.readBoolOrNull(offsets[1]),
    positiveHits: reader.readLongOrNull(offsets[2]) ?? 0,
    query: reader.readString(offsets[3]),
    sigma: reader.readDoubleOrNull(offsets[4]) ?? 0.0,
    timestamp: reader.readDateTime(offsets[5]),
    totalSamples: reader.readLong(offsets[6]),
    type: _ChronosEventtypeValueEnumMap[reader.readStringOrNull(offsets[7])] ??
        EventType.decision,
  );
  object.id = id;
  return object;
}

P _chronosEventDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (_ChronosEventtypeValueEnumMap[reader.readStringOrNull(offset)] ??
          EventType.decision) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChronosEventtypeEnumValueMap = {
  r'decision': r'decision',
  r'prediction': r'prediction',
  r'calibration': r'calibration',
};
const _ChronosEventtypeValueEnumMap = {
  r'decision': EventType.decision,
  r'prediction': EventType.prediction,
  r'calibration': EventType.calibration,
};

Id _chronosEventGetId(ChronosEvent object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chronosEventGetLinks(ChronosEvent object) {
  return [];
}

void _chronosEventAttach(
    IsarCollection<dynamic> col, Id id, ChronosEvent object) {
  object.id = id;
}

extension ChronosEventQueryWhereSort
    on QueryBuilder<ChronosEvent, ChronosEvent, QWhere> {
  QueryBuilder<ChronosEvent, ChronosEvent, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChronosEventQueryWhere
    on QueryBuilder<ChronosEvent, ChronosEvent, QWhereClause> {
  QueryBuilder<ChronosEvent, ChronosEvent, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChronosEventQueryFilter
    on QueryBuilder<ChronosEvent, ChronosEvent, QFilterCondition> {
  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      importanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importance',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      importanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importance',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      importanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importance',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      importanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      isFulfilledIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFulfilled',
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      isFulfilledIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFulfilled',
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      isFulfilledEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFulfilled',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      positiveHitsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positiveHits',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      positiveHitsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positiveHits',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      positiveHitsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positiveHits',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      positiveHitsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positiveHits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> queryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      queryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> queryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> queryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'query',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      queryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> queryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> queryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'query',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> queryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'query',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      queryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'query',
        value: '',
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      queryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'query',
        value: '',
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> sigmaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sigma',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      sigmaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sigma',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> sigmaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sigma',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> sigmaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sigma',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      totalSamplesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSamples',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      totalSamplesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSamples',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      totalSamplesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSamples',
        value: value,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      totalSamplesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSamples',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> typeEqualTo(
    EventType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      typeGreaterThan(
    EventType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> typeLessThan(
    EventType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> typeBetween(
    EventType lower,
    EventType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ChronosEventQueryObject
    on QueryBuilder<ChronosEvent, ChronosEvent, QFilterCondition> {}

extension ChronosEventQueryLinks
    on QueryBuilder<ChronosEvent, ChronosEvent, QFilterCondition> {}

extension ChronosEventQuerySortBy
    on QueryBuilder<ChronosEvent, ChronosEvent, QSortBy> {
  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByImportance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      sortByImportanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByIsFulfilled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFulfilled', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      sortByIsFulfilledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFulfilled', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByPositiveHits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positiveHits', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      sortByPositiveHitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positiveHits', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByQuery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByQueryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortBySigma() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigma', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortBySigmaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigma', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByTotalSamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSamples', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      sortByTotalSamplesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSamples', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChronosEventQuerySortThenBy
    on QueryBuilder<ChronosEvent, ChronosEvent, QSortThenBy> {
  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByImportance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      thenByImportanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByIsFulfilled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFulfilled', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      thenByIsFulfilledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFulfilled', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByPositiveHits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positiveHits', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      thenByPositiveHitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positiveHits', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByQuery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByQueryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'query', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenBySigma() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigma', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenBySigmaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigma', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByTotalSamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSamples', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy>
      thenByTotalSamplesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSamples', Sort.desc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChronosEventQueryWhereDistinct
    on QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> {
  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByImportance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'importance');
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByIsFulfilled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFulfilled');
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByPositiveHits() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positiveHits');
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByQuery(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'query', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctBySigma() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sigma');
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByTotalSamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSamples');
    });
  }

  QueryBuilder<ChronosEvent, ChronosEvent, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ChronosEventQueryProperty
    on QueryBuilder<ChronosEvent, ChronosEvent, QQueryProperty> {
  QueryBuilder<ChronosEvent, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChronosEvent, int, QQueryOperations> importanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importance');
    });
  }

  QueryBuilder<ChronosEvent, bool?, QQueryOperations> isFulfilledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFulfilled');
    });
  }

  QueryBuilder<ChronosEvent, int, QQueryOperations> positiveHitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positiveHits');
    });
  }

  QueryBuilder<ChronosEvent, String, QQueryOperations> queryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'query');
    });
  }

  QueryBuilder<ChronosEvent, double, QQueryOperations> sigmaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sigma');
    });
  }

  QueryBuilder<ChronosEvent, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<ChronosEvent, int, QQueryOperations> totalSamplesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSamples');
    });
  }

  QueryBuilder<ChronosEvent, EventType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
