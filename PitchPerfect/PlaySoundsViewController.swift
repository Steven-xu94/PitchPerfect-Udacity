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

    var receivedAudio: RecordedAudio!
    private var audioPlayer: AVAudioPlayer!
    private var audioEngine: AVAudioEngine!
    private var audioFile: AVAudioFile!
    
    private func playWithRate(rate: float_t) {
        audioPlayer.stop()
        audioPlayer.enableRate = true
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
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
    
    func playAudioWithPitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try? audioEngine.start()
        audioPlayerNode.play()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithPitch(1000)
    }
    
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithPitch(-1000)
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
