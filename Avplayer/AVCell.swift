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
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    @IBOutlet weak var videoLendthLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var avPlayerView: UIView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var speakerOn: UIImageView!
    
    var isPlaying = false
    
    var videoURL : URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.speakerOn.isHidden = true
        }
        buttonOutlet.alpha = 0
        sliderOutlet.minimumTrackTintColor = .red
        sliderOutlet.maximumTrackTintColor = .white
    }
    
    
    func createPlayer() {
        let player = AVPlayer(url: videoURL!)
        videoLayer.player = player
        videoLayer.frame = avPlayerView.bounds
        videoLayer.videoGravity = .resizeAspectFill
        avPlayerView.layer.addSublayer(videoLayer)
//        player.cancelPendingPrerolls()
        stoppdPlayer()
        
    }
    
    private func stoppdPlayer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasStopd))
        avPlayerView.addGestureRecognizer(tap)
    }
    
    @objc func wasStopd() {
        speakerOn.isHidden = false
        buttonOutlet.alpha = 1
        if videoLayer.player?.volume == 1.0 {
            videoLayer.player?.volume = 0.0
            speakerOn.image = UIImage(named: "mute")
        }else {
            videoLayer.player?.volume = 1.0
            speakerOn.image = UIImage(named: "speaker")
        }
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (timer) in
            self.speakerOn.isHidden = true
            self.buttonOutlet.alpha = 0
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
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
