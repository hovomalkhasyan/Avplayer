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

    var videoURL : URL?
    override func awakeFromNib() {
        super.awakeFromNib()
//        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        

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
        videoLayer.player?.pause()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
