//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import assets_audio_player
import assets_audio_player_web
import path_provider_macos
import shared_preferences_macos
import window_utils

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AssetsAudioPlayerPlugin.register(with: registry.registrar(forPlugin: "AssetsAudioPlayerPlugin"))
  AssetsAudioPlayerWebPlugin.register(with: registry.registrar(forPlugin: "AssetsAudioPlayerWebPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  WindowUtils.register(with: registry.registrar(forPlugin: "WindowUtils"))
}
