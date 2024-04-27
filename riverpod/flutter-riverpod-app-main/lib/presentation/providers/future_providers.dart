import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_app/config/config.dart';

part 'future_providers.g.dart';

@Riverpod(keepAlive: true)
Future<String> pokemonName(PokemonNameRef ref) async {
  final pokemonId = ref.watch(pokemonIdProvider);

  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);

  ref.onDispose(() {
    // ignore: avoid_print
    print('Estamos a punto de eliminar este provider');
  });

  return pokemonName;
}

@Riverpod(keepAlive: true)
class PokemonId extends _$PokemonId {
  @override
  int build() => 1;

  void nextPokemon() {
    state++;
  }

  void prevPokemon() {
    if (state > 0) {
      state--;
    }
  }
}

//* Anteriormente llamados Family
//* Esto permite que cada parametro diferente tenga su propio estado
//* Por lo tanto cada id solo se consultara 1 vez, evitando doble fetch
@Riverpod(keepAlive: true)
Future<String> pokemon(PokemonRef ref, int pokemonId) async {
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);

  return pokemonName;
}
