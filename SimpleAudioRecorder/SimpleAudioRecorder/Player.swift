//
//  Player.swift
//  SimpleAudioRecorder
//
//  Created by Jordan Christensen on 10/30/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

protocol PlayerDelegate {
    func playerDidChangeState(_ player: Player)
}

class Player: NSObject {
    var audioPlayer: AVAudioPlayer?
    var delegate: PlayerDelegate?
    
    override init() {
        let songURL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: songURL)
        } catch {
            NSLog("AudioPlayer error: \(error)")
        }
        
        super.init()
        audioPlayer?.delegate = self
    }
    
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    func play() {
        audioPlayer?.play()
        delegate?.playerDidChangeState(self)
    }
    
    func pause() {
        audioPlayer?.pause()
        delegate?.playerDidChangeState(self)
    }
    
    func playPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
}

extension Player: AVAudioPlayerDelegate {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        NSLog("AVAudioError: \(String(describing: error))")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.playerDidChangeState(self)
    }
}
