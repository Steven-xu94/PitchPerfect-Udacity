//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Steven Xu on 2015-05-22.
//  Copyright (c) 2015 Steven Xu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide stop button
        stopButton.hidden = true;
        recordButton.enabled = true;
        recordingInProgress.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false;
        recordingInProgress.hidden = false;
        recordButton.enabled = false;
        
        let dest = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMddyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let path = [dest + recordingName]
        let filePath = NSURL.fileURLWithPathComponents(path)
        print(filePath)
        
        // setup audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        
        // initialize recorder
        audioRecorder = try? AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            // save the recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
            // perform segue (move to next scene)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            
        } else {
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true;
        
        audioRecorder.stop()
        let audiosession = AVAudioSession.sharedInstance()
        do {
            try audiosession.setActive(false)
        } catch _ {
        }
        
    }
}

