//
//  AVCell.swift
//  Avplayer
//
//  Created by Hovo on 9/3/20.
//  Copyright © 2020 Hovo. All rights reserved.
//


import UIKit
import AVKit
import AVFoundation

class AVCell: UITableViewCell {
//MARK: Outlets
    @IBOutlet weak var avPlayerView: UIView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var speakerButtonOutlet : UIButton!

//MARK: Properties
 
    var isPlaying = false
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var videoURL : URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.speakerButtonOutlet.alpha = 0
        }
        buttonOutlet.alpha = 0
    }
    
    
    func createPlayer() {
        let player = AVPlayer(url: videoURL!)
        videoLayer.player = player
        videoLayer.frame = avPlayerView.bounds
        videoLayer.videoGravity = .resizeAspectFill
        avPlayerView.layer.addSublayer(videoLayer)
        stoppdPlayer()
        
    }
    
    private func stoppdPlayer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasStopd))
        avPlayerView.addGestureRecognizer(tap)
    }
    
    @objc func wasStopd() {
        buttonOutlet.alpha = 1
        speakerButtonOutlet.alpha = 1
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.buttonOutlet.alpha = 0
            self.speakerButtonOutlet.alpha = 0
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if isPlaying {
            videoLayer.player?.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
        }else {
            videoLayer.player?.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (timer) in
            self.buttonOutlet.alpha = 0
        }
        
    }
   
    @IBAction func speakerOnBtn(_ sender: UIButton) {
         buttonOutlet.isHidden = false
        if videoLayer.player?.volume == 1.0 {
            videoLayer.player?.volume = 0.0
            speakerButtonOutlet.setImage(UIImage(named: "mute"), for: .normal)
        }else {
            videoLayer.player?.volume = 1.0
            speakerButtonOutlet.setImage(UIImage(named: "speaker"), for: .normal)
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            
            self.speakerButtonOutlet.alpha = 0
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
