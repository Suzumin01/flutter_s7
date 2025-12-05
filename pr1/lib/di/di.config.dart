// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pr1/data/db/game_genre_database.dart' as _i286;
import 'package:pr1/data/repositories/game_genre_repository.dart' as _i468;
import 'package:pr1/features/game_genres/presentation/bloc/game_genre_bloc.dart'
    as _i410;
import 'package:pr1/theme/theme_cubit.dart' as _i768;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i768.ThemeCubit>(() => _i768.ThemeCubit());
    gh.lazySingleton<_i286.AppDatabase>(() => _i286.AppDatabase());
    gh.lazySingleton<_i468.GameGenreRepository>(
      () => _i468.GameGenreRepository(gh<_i286.AppDatabase>()),
    );
    gh.factory<_i410.GameGenreBloc>(
      () => _i410.GameGenreBloc(gh<_i468.GameGenreRepository>()),
    );
    return this;
  }
}
