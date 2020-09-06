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
    @IBOutlet weak var avPlayerView: UIView!
    @IBOutlet weak var speakerOn: UIImageView!
    
    var videoURL : URL?
    override func awakeFromNib() {
        super.awakeFromNib()
        avPlayerView.addSubview(speakerOn)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.speakerOn.isHidden = true
        }
    }
    
    func createPlayer() {
        let player = AVPlayer(url: videoURL!)
        videoLayer.player = player
        videoLayer.frame = avPlayerView.bounds
        avPlayerView.layer.addSublayer(videoLayer)
        stoppdPlayer()
    }
    
    private func stoppdPlayer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasStopd))
        avPlayerView.addGestureRecognizer(tap)
    }
    
    @objc func wasStopd() {
        speakerOn.isHidden = false
        if videoLayer.player?.volume == 1.0 {
            videoLayer.player?.volume = 0.0
            speakerOn.image = UIImage(named: "mute")
        }else {
            videoLayer.player?.volume = 1.0
            speakerOn.image = UIImage(named: "speaker")
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.speakerOn.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
