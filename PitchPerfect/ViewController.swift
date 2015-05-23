//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Steven Xu on 2015-05-22.
//  Copyright (c) 2015 Steven Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
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
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false;
        // show text "Recording in progress" when button clicked
        recordingInProgress.hidden = false;
        // TODO: Record
        recordButton.enabled = false;
        
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true;
    }
    

}

