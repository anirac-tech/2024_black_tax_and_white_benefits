// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesRepositoryHash() =>
    r'5f99dcd24c9d465d7cf553d878c6bae1a4a0c318';

/// See also [favoritesRepository].
@ProviderFor(favoritesRepository)
final favoritesRepositoryProvider =
    AutoDisposeProvider<FavoritesRepository>.internal(
  favoritesRepository,
  name: r'favoritesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesRepositoryRef = AutoDisposeProviderRef<FavoritesRepository>;
String _$favoriteListHash() => r'4bd2df41778080b79e5ff7429d18c21aa931eca6';

/// See also [favoriteList].
@ProviderFor(favoriteList)
final favoriteListProvider = AutoDisposeStreamProvider<List<Post>>.internal(
  favoriteList,
  name: r'favoriteListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favoriteListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteListRef = AutoDisposeStreamProviderRef<List<Post>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
