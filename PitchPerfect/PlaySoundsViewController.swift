//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Steven Xu on 2015-05-23.
//  Copyright (c) 2015 Steven Xu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    private var audioPlayer: AVAudioPlayer!
    
    private func playWithRate(rate: float_t) {
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if var path = NSBundle.mainBundle().pathForResource("Sh-Boom", ofType: "m4a") {
            var url = NSURL.fileURLWithPath(path)
            audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
        } else {
            println("File not found")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowly(sender: AnyObject) {
        playWithRate(0.5)
    }
    
    
    @IBAction func playFast(sender: AnyObject) {
        playWithRate(1.5)
    }
    
    
    @IBAction func stopPlaying(sender: AnyObject) {
        audioPlayer.stop()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
