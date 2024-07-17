// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

// part of 'failure.dart';

// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************

// T _$identity<T>(T value) => value;

// final _privateConstructorUsedError = UnsupportedError(
//     'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

// /// @nodoc
// mixin _$ResponseFailure {
//   String get message => throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(String message) invalidCredential,
//     required TResult Function(String message) noAdminAccess,
//     required TResult Function(String message) networkFailure,
//     required TResult Function(String message) unknown,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(String message)? invalidCredential,
//     TResult? Function(String message)? noAdminAccess,
//     TResult? Function(String message)? networkFailure,
//     TResult? Function(String message)? unknown,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(String message)? invalidCredential,
//     TResult Function(String message)? noAdminAccess,
//     TResult Function(String message)? networkFailure,
//     TResult Function(String message)? unknown,
//     required TResult orElse(),
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(InvalidCredentials value) invalidCredential,
//     required TResult Function(NoAdminAccess value) noAdminAccess,
//     required TResult Function(NetworkFailure value) networkFailure,
//     required TResult Function(Unknown value) unknown,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(InvalidCredentials value)? invalidCredential,
//     TResult? Function(NoAdminAccess value)? noAdminAccess,
//     TResult? Function(NetworkFailure value)? networkFailure,
//     TResult? Function(Unknown value)? unknown,
//   }) =>
//       throw _privateConstructorUsedError;
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(InvalidCredentials value)? invalidCredential,
//     TResult Function(NoAdminAccess value)? noAdminAccess,
//     TResult Function(NetworkFailure value)? networkFailure,
//     TResult Function(Unknown value)? unknown,
//     required TResult orElse(),
//   }) =>
//       throw _privateConstructorUsedError;

//   @JsonKey(ignore: true)
//   $ResponseFailureCopyWith<ResponseFailure> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class $ResponseFailureCopyWith<$Res> {
//   factory $ResponseFailureCopyWith(
//           ResponseFailure value, $Res Function(ResponseFailure) then) =
//       _$ResponseFailureCopyWithImpl<$Res, ResponseFailure>;
//   @useResult
//   $Res call({String message});
// }

// /// @nodoc
// class _$ResponseFailureCopyWithImpl<$Res, $Val extends ResponseFailure>
//     implements $ResponseFailureCopyWith<$Res> {
//   _$ResponseFailureCopyWithImpl(this._value, this._then);

//   // ignore: unused_field
//   final $Val _value;
//   // ignore: unused_field
//   final $Res Function($Val) _then;

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_value.copyWith(
//       message: null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ) as $Val);
//   }
// }

// /// @nodoc
// abstract class _$$InvalidCredentialsImplCopyWith<$Res>
//     implements $ResponseFailureCopyWith<$Res> {
//   factory _$$InvalidCredentialsImplCopyWith(_$InvalidCredentialsImpl value,
//           $Res Function(_$InvalidCredentialsImpl) then) =
//       __$$InvalidCredentialsImplCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call({String message});
// }

// /// @nodoc
// class __$$InvalidCredentialsImplCopyWithImpl<$Res>
//     extends _$ResponseFailureCopyWithImpl<$Res, _$InvalidCredentialsImpl>
//     implements _$$InvalidCredentialsImplCopyWith<$Res> {
//   __$$InvalidCredentialsImplCopyWithImpl(_$InvalidCredentialsImpl _value,
//       $Res Function(_$InvalidCredentialsImpl) _then)
//       : super(_value, _then);

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_$InvalidCredentialsImpl(
//       message: null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }

// /// @nodoc

// class _$InvalidCredentialsImpl implements InvalidCredentials {
//   const _$InvalidCredentialsImpl({required this.message});

//   @override
//   final String message;

//   @override
//   String toString() {
//     return 'ResponseFailure.invalidCredential(message: $message)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$InvalidCredentialsImpl &&
//             (identical(other.message, message) || other.message == message));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, message);

//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$InvalidCredentialsImplCopyWith<_$InvalidCredentialsImpl> get copyWith =>
//       __$$InvalidCredentialsImplCopyWithImpl<_$InvalidCredentialsImpl>(
//           this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(String message) invalidCredential,
//     required TResult Function(String message) noAdminAccess,
//     required TResult Function(String message) networkFailure,
//     required TResult Function(String message) unknown,
//   }) {
//     return invalidCredential(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(String message)? invalidCredential,
//     TResult? Function(String message)? noAdminAccess,
//     TResult? Function(String message)? networkFailure,
//     TResult? Function(String message)? unknown,
//   }) {
//     return invalidCredential?.call(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(String message)? invalidCredential,
//     TResult Function(String message)? noAdminAccess,
//     TResult Function(String message)? networkFailure,
//     TResult Function(String message)? unknown,
//     required TResult orElse(),
//   }) {
//     if (invalidCredential != null) {
//       return invalidCredential(message);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(InvalidCredentials value) invalidCredential,
//     required TResult Function(NoAdminAccess value) noAdminAccess,
//     required TResult Function(NetworkFailure value) networkFailure,
//     required TResult Function(Unknown value) unknown,
//   }) {
//     return invalidCredential(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(InvalidCredentials value)? invalidCredential,
//     TResult? Function(NoAdminAccess value)? noAdminAccess,
//     TResult? Function(NetworkFailure value)? networkFailure,
//     TResult? Function(Unknown value)? unknown,
//   }) {
//     return invalidCredential?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(InvalidCredentials value)? invalidCredential,
//     TResult Function(NoAdminAccess value)? noAdminAccess,
//     TResult Function(NetworkFailure value)? networkFailure,
//     TResult Function(Unknown value)? unknown,
//     required TResult orElse(),
//   }) {
//     if (invalidCredential != null) {
//       return invalidCredential(this);
//     }
//     return orElse();
//   }
// }

// abstract class InvalidCredentials implements ResponseFailure {
//   const factory InvalidCredentials({required final String message}) =
//       _$InvalidCredentialsImpl;

//   @override
//   String get message;
//   @override
//   @JsonKey(ignore: true)
//   _$$InvalidCredentialsImplCopyWith<_$InvalidCredentialsImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class _$$NoAdminAccessImplCopyWith<$Res>
//     implements $ResponseFailureCopyWith<$Res> {
//   factory _$$NoAdminAccessImplCopyWith(
//           _$NoAdminAccessImpl value, $Res Function(_$NoAdminAccessImpl) then) =
//       __$$NoAdminAccessImplCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call({String message});
// }

// /// @nodoc
// class __$$NoAdminAccessImplCopyWithImpl<$Res>
//     extends _$ResponseFailureCopyWithImpl<$Res, _$NoAdminAccessImpl>
//     implements _$$NoAdminAccessImplCopyWith<$Res> {
//   __$$NoAdminAccessImplCopyWithImpl(
//       _$NoAdminAccessImpl _value, $Res Function(_$NoAdminAccessImpl) _then)
//       : super(_value, _then);

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_$NoAdminAccessImpl(
//       message: null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }

// /// @nodoc

// class _$NoAdminAccessImpl implements NoAdminAccess {
//   const _$NoAdminAccessImpl({required this.message});

//   @override
//   final String message;

//   @override
//   String toString() {
//     return 'ResponseFailure.noAdminAccess(message: $message)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$NoAdminAccessImpl &&
//             (identical(other.message, message) || other.message == message));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, message);

//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$NoAdminAccessImplCopyWith<_$NoAdminAccessImpl> get copyWith =>
//       __$$NoAdminAccessImplCopyWithImpl<_$NoAdminAccessImpl>(this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(String message) invalidCredential,
//     required TResult Function(String message) noAdminAccess,
//     required TResult Function(String message) networkFailure,
//     required TResult Function(String message) unknown,
//   }) {
//     return noAdminAccess(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(String message)? invalidCredential,
//     TResult? Function(String message)? noAdminAccess,
//     TResult? Function(String message)? networkFailure,
//     TResult? Function(String message)? unknown,
//   }) {
//     return noAdminAccess?.call(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(String message)? invalidCredential,
//     TResult Function(String message)? noAdminAccess,
//     TResult Function(String message)? networkFailure,
//     TResult Function(String message)? unknown,
//     required TResult orElse(),
//   }) {
//     if (noAdminAccess != null) {
//       return noAdminAccess(message);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(InvalidCredentials value) invalidCredential,
//     required TResult Function(NoAdminAccess value) noAdminAccess,
//     required TResult Function(NetworkFailure value) networkFailure,
//     required TResult Function(Unknown value) unknown,
//   }) {
//     return noAdminAccess(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(InvalidCredentials value)? invalidCredential,
//     TResult? Function(NoAdminAccess value)? noAdminAccess,
//     TResult? Function(NetworkFailure value)? networkFailure,
//     TResult? Function(Unknown value)? unknown,
//   }) {
//     return noAdminAccess?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(InvalidCredentials value)? invalidCredential,
//     TResult Function(NoAdminAccess value)? noAdminAccess,
//     TResult Function(NetworkFailure value)? networkFailure,
//     TResult Function(Unknown value)? unknown,
//     required TResult orElse(),
//   }) {
//     if (noAdminAccess != null) {
//       return noAdminAccess(this);
//     }
//     return orElse();
//   }
// }

// abstract class NoAdminAccess implements ResponseFailure {
//   const factory NoAdminAccess({required final String message}) =
//       _$NoAdminAccessImpl;

//   @override
//   String get message;
//   @override
//   @JsonKey(ignore: true)
//   _$$NoAdminAccessImplCopyWith<_$NoAdminAccessImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class _$$NetworkFailureImplCopyWith<$Res>
//     implements $ResponseFailureCopyWith<$Res> {
//   factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
//           $Res Function(_$NetworkFailureImpl) then) =
//       __$$NetworkFailureImplCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call({String message});
// }

// /// @nodoc
// class __$$NetworkFailureImplCopyWithImpl<$Res>
//     extends _$ResponseFailureCopyWithImpl<$Res, _$NetworkFailureImpl>
//     implements _$$NetworkFailureImplCopyWith<$Res> {
//   __$$NetworkFailureImplCopyWithImpl(
//       _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
//       : super(_value, _then);

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_$NetworkFailureImpl(
//       message: null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }

// /// @nodoc

// class _$NetworkFailureImpl implements NetworkFailure {
//   const _$NetworkFailureImpl({required this.message});

//   @override
//   final String message;

//   @override
//   String toString() {
//     return 'ResponseFailure.networkFailure(message: $message)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$NetworkFailureImpl &&
//             (identical(other.message, message) || other.message == message));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, message);

//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
//       __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
//           this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(String message) invalidCredential,
//     required TResult Function(String message) noAdminAccess,
//     required TResult Function(String message) networkFailure,
//     required TResult Function(String message) unknown,
//   }) {
//     return networkFailure(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(String message)? invalidCredential,
//     TResult? Function(String message)? noAdminAccess,
//     TResult? Function(String message)? networkFailure,
//     TResult? Function(String message)? unknown,
//   }) {
//     return networkFailure?.call(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(String message)? invalidCredential,
//     TResult Function(String message)? noAdminAccess,
//     TResult Function(String message)? networkFailure,
//     TResult Function(String message)? unknown,
//     required TResult orElse(),
//   }) {
//     if (networkFailure != null) {
//       return networkFailure(message);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(InvalidCredentials value) invalidCredential,
//     required TResult Function(NoAdminAccess value) noAdminAccess,
//     required TResult Function(NetworkFailure value) networkFailure,
//     required TResult Function(Unknown value) unknown,
//   }) {
//     return networkFailure(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(InvalidCredentials value)? invalidCredential,
//     TResult? Function(NoAdminAccess value)? noAdminAccess,
//     TResult? Function(NetworkFailure value)? networkFailure,
//     TResult? Function(Unknown value)? unknown,
//   }) {
//     return networkFailure?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(InvalidCredentials value)? invalidCredential,
//     TResult Function(NoAdminAccess value)? noAdminAccess,
//     TResult Function(NetworkFailure value)? networkFailure,
//     TResult Function(Unknown value)? unknown,
//     required TResult orElse(),
//   }) {
//     if (networkFailure != null) {
//       return networkFailure(this);
//     }
//     return orElse();
//   }
// }

// abstract class NetworkFailure implements ResponseFailure {
//   const factory NetworkFailure({required final String message}) =
//       _$NetworkFailureImpl;

//   @override
//   String get message;
//   @override
//   @JsonKey(ignore: true)
//   _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class _$$UnknownImplCopyWith<$Res>
//     implements $ResponseFailureCopyWith<$Res> {
//   factory _$$UnknownImplCopyWith(
//           _$UnknownImpl value, $Res Function(_$UnknownImpl) then) =
//       __$$UnknownImplCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call({String message});
// }

// /// @nodoc
// class __$$UnknownImplCopyWithImpl<$Res>
//     extends _$ResponseFailureCopyWithImpl<$Res, _$UnknownImpl>
//     implements _$$UnknownImplCopyWith<$Res> {
//   __$$UnknownImplCopyWithImpl(
//       _$UnknownImpl _value, $Res Function(_$UnknownImpl) _then)
//       : super(_value, _then);

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_$UnknownImpl(
//       message: null == message
//           ? _value.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }

// /// @nodoc

// class _$UnknownImpl implements Unknown {
//   const _$UnknownImpl({required this.message});

//   @override
//   final String message;

//   @override
//   String toString() {
//     return 'ResponseFailure.unknown(message: $message)';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$UnknownImpl &&
//             (identical(other.message, message) || other.message == message));
//   }

//   @override
//   int get hashCode => Object.hash(runtimeType, message);

//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$UnknownImplCopyWith<_$UnknownImpl> get copyWith =>
//       __$$UnknownImplCopyWithImpl<_$UnknownImpl>(this, _$identity);

//   @override
//   @optionalTypeArgs
//   TResult when<TResult extends Object?>({
//     required TResult Function(String message) invalidCredential,
//     required TResult Function(String message) noAdminAccess,
//     required TResult Function(String message) networkFailure,
//     required TResult Function(String message) unknown,
//   }) {
//     return unknown(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? whenOrNull<TResult extends Object?>({
//     TResult? Function(String message)? invalidCredential,
//     TResult? Function(String message)? noAdminAccess,
//     TResult? Function(String message)? networkFailure,
//     TResult? Function(String message)? unknown,
//   }) {
//     return unknown?.call(message);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeWhen<TResult extends Object?>({
//     TResult Function(String message)? invalidCredential,
//     TResult Function(String message)? noAdminAccess,
//     TResult Function(String message)? networkFailure,
//     TResult Function(String message)? unknown,
//     required TResult orElse(),
//   }) {
//     if (unknown != null) {
//       return unknown(message);
//     }
//     return orElse();
//   }

//   @override
//   @optionalTypeArgs
//   TResult map<TResult extends Object?>({
//     required TResult Function(InvalidCredentials value) invalidCredential,
//     required TResult Function(NoAdminAccess value) noAdminAccess,
//     required TResult Function(NetworkFailure value) networkFailure,
//     required TResult Function(Unknown value) unknown,
//   }) {
//     return unknown(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult? mapOrNull<TResult extends Object?>({
//     TResult? Function(InvalidCredentials value)? invalidCredential,
//     TResult? Function(NoAdminAccess value)? noAdminAccess,
//     TResult? Function(NetworkFailure value)? networkFailure,
//     TResult? Function(Unknown value)? unknown,
//   }) {
//     return unknown?.call(this);
//   }

//   @override
//   @optionalTypeArgs
//   TResult maybeMap<TResult extends Object?>({
//     TResult Function(InvalidCredentials value)? invalidCredential,
//     TResult Function(NoAdminAccess value)? noAdminAccess,
//     TResult Function(NetworkFailure value)? networkFailure,
//     TResult Function(Unknown value)? unknown,
//     required TResult orElse(),
//   }) {
//     if (unknown != null) {
//       return unknown(this);
//     }
//     return orElse();
//   }
// }

// abstract class Unknown implements ResponseFailure {
//   const factory Unknown({required final String message}) = _$UnknownImpl;

//   @override
//   String get message;
//   @override
//   @JsonKey(ignore: true)
//   _$$UnknownImplCopyWith<_$UnknownImpl> get copyWith =>
//       throw _privateConstructorUsedError;
// }
