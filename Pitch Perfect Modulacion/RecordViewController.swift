//
//  RecordViewController.swift
//  Pitch Perfect Modulacion
//
//  Created by Laxman Nyamagouda on 4/22/20.
//  Copyright © 2020 Laxman Nyamagouda. All rights reserved.
//

import UIKit
import AVFoundation

enum RecordingState {
   case  recording
  case notRecording
}

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewWillAppear(_ animated: Bool) {
        
        configureUI(.notRecording)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        configureUI(.recording)
        let searchURL = RecordViewModel().recordAudioURL()
        let session = AVAudioSession.sharedInstance()
        
        do {
            let session: () = try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            print(session)
        } catch {
            print("session not started")
        }
        
        try! audioRecorder = AVAudioRecorder(url: searchURL as URL, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
        configureUI(.notRecording)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let session: () = try audioSession.setActive(false)
                  print(session)
        } catch {
            print("session not active")
        }
        
    }
    
    func  configureUI(_ recordingState: RecordingState) {
        switch recordingState {
        case .recording:
            // Update the UI to reflect recording state
            tapToRecord.text = "Recording in Progress..."
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        case .notRecording:
            // Update the UI to reflect not recording state
            tapToRecord.text = "Tap to Record"
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecording" {
            let playSoundVC = segue.destination as! PlayViewController
            let recordAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordAudioURL
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "StopRecording", sender: audioRecorder.url)
        } else {
            let alert = UIAlertController(title: "Pitch Perfect!", message: "Failed to save Audio. Please retry after sometime..", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}

