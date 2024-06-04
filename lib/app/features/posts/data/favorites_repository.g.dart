// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteListHash() => r'747fe666d16d001548e715413b5520531006cd1d';

/// See also [favoriteList].
@ProviderFor(favoriteList)
final favoriteListProvider = StreamProvider<List<Post>>.internal(
  favoriteList,
  name: r'favoriteListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favoriteListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteListRef = StreamProviderRef<List<Post>>;
String _$favoritesRepositoryHash() =>
    r'8240878dbd4cbab0f70a15d4bcbf1df1f2f6277b';

/// See also [FavoritesRepository].
@ProviderFor(FavoritesRepository)
final favoritesRepositoryProvider = AutoDisposeNotifierProvider<
    FavoritesRepository, FavoritesRepository>.internal(
  FavoritesRepository.new,
  name: r'favoritesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritesRepository = AutoDisposeNotifier<FavoritesRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
