//
//  SoundPlayer.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/17/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import AVFoundation

/// Useful for playing sounds
class SoundPlayer {
    /// A cache of audio players.
    private static var players = [String: AVAudioPlayer]()
    
    /**
     Play a sound using the name and ext of an audio file in the main bundle.
     
     - Parameter name: The name of the file.
     - Parameter ext: The file extension.
    */
    static func playSound(name: String, ext: String) {
        // If a matching player is found in the cache, use that to play the sound
        if let player = players[name + ext] {
            player.play()
            return
        }
        
        // Get the url
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("Could not get url for name: \(name), ext: \(ext)")
            return
        }
        
        // Create the player and play the sound
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            players[name + ext] = player
            player.play()
        } catch {
            print("Error creating AVAudioPlayer: name: \(name), ext: \(ext)")
            print(error)
            return
        }
    }
}
