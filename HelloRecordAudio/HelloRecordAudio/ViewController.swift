//
//  ViewController.swift
//  HelloRecordAudio
//
//  Created by Yilin on 2019/7/27.
//  Copyright © 2019 Yilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var recordHelper: RecordHelper?

    @IBAction func startRecord(_: UIButton) {
        recordHelper?.startRecord()
    }

    @IBAction func stopRecording(_: UIButton) {
        recordHelper?.stopRecording()
    }

    @IBAction func play(_: UIButton) {
        recordHelper?.play()
    }

    @IBAction func stopPlaying(_: UIButton) {
        recordHelper?.stopPlaying()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        recordHelper = RecordHelper()
    }
}
