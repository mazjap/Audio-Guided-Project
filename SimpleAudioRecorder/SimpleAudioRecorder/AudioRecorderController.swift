//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Paul Solt on 10/1/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class AudioRecorderController: UIViewController {
    
    var player: Player
    var recorder: Recorder
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
	
	private lazy var timeFormatter: DateComponentsFormatter = {
		let formatting = DateComponentsFormatter()
		formatting.unitsStyle = .positional // 00:00  mm:ss
		// NOTE: DateComponentFormatter is good for minutes/hours/seconds
		// DateComponentsFormatter not good for milliseconds, use DateFormatter instead)
		formatting.zeroFormattingBehavior = .pad
		formatting.allowedUnits = [.minute, .second]
		return formatting
	}()
    
    // Gets called when a view controller is created from a storyboard
    required init?(coder: NSCoder) {
        recorder = Recorder()
        player = Player()
        super.init(coder: coder)
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()

        player.delegate = self
        recorder.delegate = self

        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize,
                                                          weight: .regular)
        timeRemainingLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeRemainingLabel.font.pointSize,
                                                                   weight: .regular)
	}


    @IBAction func playButtonPressed(_ sender: Any) {
        player.playPause()
	}
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        recorder.toggleRecoring()
    }
    
    private func updateViews() {
        let recordTitle = recorder.isRecording ? "Stop Recording" : "Record"
        let playTitle = player.isPlaying ? "Pause" : "Play"
        playButton.setTitle(playTitle, for: .normal)
        recordButton.setTitle(recordTitle, for: .normal)
    }
}

extension AudioRecorderController: PlayerDelegate {
    func playerDidChangeState(_ player: Player) {
        updateViews()
    }
}

extension AudioRecorderController: RecorderDelegate {
    func recorderDidChangeState(_ recorder: Recorder) {
        updateViews()
    }
    
    func recorderDidSaveFile(_ recorder: Recorder) {
        updateViews()
        //TODO: play the file
        if let url = recorder.fileURL, !recorder.isRecording {
            self.player = Player(url: url)
            player.delegate = self
        }
    }
}
