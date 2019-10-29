//
//  Player.swift
//  SimpleAudioRecorder
//
//  Created by Jordan Christensen on 10/30/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

class Player: NSObject {
    var audioPlayer: AVAudioPlayer?
    override init() {
        let songURL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: songURL)
        } catch {
            NSLog("AudioPlayer error: \(error)")
        }
        
        super.init()
        
    }
    
}
