//
//  RecordHelper.swift
//  HelloRecordAudio
//
//  Created by Yilin on 2019/7/27.
//  Copyright © 2019 Yilin. All rights reserved.
//

import AVFoundation
import Foundation

enum AudioSession {
    case record
    case play
}

class RecordHelper: NSObject, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var isRecording: Bool = false

    override init() {
        super.init()

        let url = getFileURL()
        print("URL: \(url)")

        let recordSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
//            AVEncoderBitRateKey: 16,
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recordSettings)
            audioRecorder?.delegate = self
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func setAudioSession(toMode mode: AudioSession) {
        audioPlayer?.stop()

        let session = AVAudioSession.sharedInstance()

        do {
            switch mode {
            case .record:
                try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            case .play:
                try session.setCategory(.playback, mode: .default, options: .defaultToSpeaker)
            }
            try session.setActive(true)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func getDocumentsDirectory() -> URL {
        // NSHomeDirectory().append("/Documents")
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func getFileURL() -> URL {
        let path = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        return path as URL
    }

    func startRecord() {
        setAudioSession(toMode: .record)
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
        isRecording = true
    }

    func stopRecording() {
        if audioRecorder != nil {
            audioRecorder?.stop()
            isRecording = false
            setAudioSession(toMode: .play)
        }
    }

    func play() {
        if isRecording == false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0.0
            audioPlayer?.volume = 10.0
            audioPlayer?.play()
        }
    }

    func stopPlaying() {
        if isRecording == false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0.0
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == true {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: recorder.url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
