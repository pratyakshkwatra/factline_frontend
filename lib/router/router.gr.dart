// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:factline/api/models/post.dart' as _i13;
import 'package:factline/api/models/user.dart' as _i12;
import 'package:factline/loading.dart' as _i4;
import 'package:factline/screens/add_post.dart' as _i1;
import 'package:factline/screens/auth/create_account.dart' as _i2;
import 'package:factline/screens/auth/login.dart' as _i5;
import 'package:factline/screens/news_full.dart' as _i6;
import 'package:factline/screens/recommendations_full.dart' as _i7;
import 'package:factline/screens/tab_view.dart' as _i3;
import 'package:factline/services/auth.dart' as _i10;
import 'package:flutter/material.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;

/// generated route for
/// [_i1.AddPostScreen]
class AddPostRoute extends _i8.PageRouteInfo<AddPostRouteArgs> {
  AddPostRoute({
    _i9.Key? key,
    required _i10.AuthService authService,
    required _i11.FlutterSecureStorage secureStorage,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         AddPostRoute.name,
         args: AddPostRouteArgs(
           key: key,
           authService: authService,
           secureStorage: secureStorage,
         ),
         initialChildren: children,
       );

  static const String name = 'AddPostRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddPostRouteArgs>();
      return _i1.AddPostScreen(
        key: args.key,
        authService: args.authService,
        secureStorage: args.secureStorage,
      );
    },
  );
}

class AddPostRouteArgs {
  const AddPostRouteArgs({
    this.key,
    required this.authService,
    required this.secureStorage,
  });

  final _i9.Key? key;

  final _i10.AuthService authService;

  final _i11.FlutterSecureStorage secureStorage;

  @override
  String toString() {
    return 'AddPostRouteArgs{key: $key, authService: $authService, secureStorage: $secureStorage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddPostRouteArgs) return false;
    return key == other.key &&
        authService == other.authService &&
        secureStorage == other.secureStorage;
  }

  @override
  int get hashCode =>
      key.hashCode ^ authService.hashCode ^ secureStorage.hashCode;
}

/// generated route for
/// [_i2.CreateAccountScreen]
class CreateAccountRoute extends _i8.PageRouteInfo<CreateAccountRouteArgs> {
  CreateAccountRoute({
    _i9.Key? key,
    required _i10.AuthService authService,
    required _i11.FlutterSecureStorage secureStorage,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         CreateAccountRoute.name,
         args: CreateAccountRouteArgs(
           key: key,
           authService: authService,
           secureStorage: secureStorage,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateAccountRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateAccountRouteArgs>();
      return _i2.CreateAccountScreen(
        key: args.key,
        authService: args.authService,
        secureStorage: args.secureStorage,
      );
    },
  );
}

class CreateAccountRouteArgs {
  const CreateAccountRouteArgs({
    this.key,
    required this.authService,
    required this.secureStorage,
  });

  final _i9.Key? key;

  final _i10.AuthService authService;

  final _i11.FlutterSecureStorage secureStorage;

  @override
  String toString() {
    return 'CreateAccountRouteArgs{key: $key, authService: $authService, secureStorage: $secureStorage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateAccountRouteArgs) return false;
    return key == other.key &&
        authService == other.authService &&
        secureStorage == other.secureStorage;
  }

  @override
  int get hashCode =>
      key.hashCode ^ authService.hashCode ^ secureStorage.hashCode;
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i9.Key? key,
    required _i10.AuthService authService,
    required _i11.FlutterSecureStorage secureStorage,
    required _i12.User user,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(
           key: key,
           authService: authService,
           secureStorage: secureStorage,
           user: user,
         ),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i3.HomeScreen(
        key: args.key,
        authService: args.authService,
        secureStorage: args.secureStorage,
        user: args.user,
      );
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.authService,
    required this.secureStorage,
    required this.user,
  });

  final _i9.Key? key;

  final _i10.AuthService authService;

  final _i11.FlutterSecureStorage secureStorage;

  final _i12.User user;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, authService: $authService, secureStorage: $secureStorage, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return key == other.key &&
        authService == other.authService &&
        secureStorage == other.secureStorage &&
        user == other.user;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      authService.hashCode ^
      secureStorage.hashCode ^
      user.hashCode;
}

/// generated route for
/// [_i4.LoadingScreen]
class LoadingRoute extends _i8.PageRouteInfo<void> {
  const LoadingRoute({List<_i8.PageRouteInfo>? children})
    : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoadingScreen();
    },
  );
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i9.Key? key,
    required _i10.AuthService authService,
    required _i11.FlutterSecureStorage secureStorage,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(
           key: key,
           authService: authService,
           secureStorage: secureStorage,
         ),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i5.LoginScreen(
        key: args.key,
        authService: args.authService,
        secureStorage: args.secureStorage,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.authService,
    required this.secureStorage,
  });

  final _i9.Key? key;

  final _i10.AuthService authService;

  final _i11.FlutterSecureStorage secureStorage;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, authService: $authService, secureStorage: $secureStorage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key &&
        authService == other.authService &&
        secureStorage == other.secureStorage;
  }

  @override
  int get hashCode =>
      key.hashCode ^ authService.hashCode ^ secureStorage.hashCode;
}

/// generated route for
/// [_i6.NewsFullScreen]
class NewsFullRoute extends _i8.PageRouteInfo<NewsFullRouteArgs> {
  NewsFullRoute({
    _i9.Key? key,
    required _i13.Post post,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         NewsFullRoute.name,
         args: NewsFullRouteArgs(key: key, post: post),
         initialChildren: children,
       );

  static const String name = 'NewsFullRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewsFullRouteArgs>();
      return _i6.NewsFullScreen(key: args.key, post: args.post);
    },
  );
}

class NewsFullRouteArgs {
  const NewsFullRouteArgs({this.key, required this.post});

  final _i9.Key? key;

  final _i13.Post post;

  @override
  String toString() {
    return 'NewsFullRouteArgs{key: $key, post: $post}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewsFullRouteArgs) return false;
    return key == other.key && post == other.post;
  }

  @override
  int get hashCode => key.hashCode ^ post.hashCode;
}

/// generated route for
/// [_i7.RecommendationsFullScreen]
class RecommendationsFullRoute
    extends _i8.PageRouteInfo<RecommendationsFullRouteArgs> {
  RecommendationsFullRoute({
    _i9.Key? key,
    required _i12.User user,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         RecommendationsFullRoute.name,
         args: RecommendationsFullRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'RecommendationsFullRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecommendationsFullRouteArgs>();
      return _i7.RecommendationsFullScreen(key: args.key, user: args.user);
    },
  );
}

class RecommendationsFullRouteArgs {
  const RecommendationsFullRouteArgs({this.key, required this.user});

  final _i9.Key? key;

  final _i12.User user;

  @override
  String toString() {
    return 'RecommendationsFullRouteArgs{key: $key, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecommendationsFullRouteArgs) return false;
    return key == other.key && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode;
}
