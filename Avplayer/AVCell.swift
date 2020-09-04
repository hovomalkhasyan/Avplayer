//
//  AVCell.swift
//  Avplayer
//
//  Created by Hovo on 9/3/20.
//  Copyright © 2020 Hovo. All rights reserved.
//
//        let videoURL = URL(string:  "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815250094987_cropped.mp4")

import UIKit
import AVKit
import AVFoundation
class AVCell: UITableViewCell {
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    @IBOutlet weak var AVplayerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        

        let player = AVPlayer(url: URL(fileURLWithPath: path!))
        videoLayer.player = player
        videoLayer.frame = AVplayerView.bounds
        AVplayerView.layer.addSublayer(videoLayer)
        stoppdPlayer()
    }
    private func stoppdPlayer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasStopd))
        AVplayerView.addGestureRecognizer(tap)
    }
    @objc func wasStopd() {
        videoLayer.player?.pause()
    }
//    func Avplayer() {
//            let videoURL = URL(string:  "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815250094987_cropped.mp4")
//            let player = AVPlayer(url: videoURL!)
//            let layer = AVPlayerLayer(player: player)
//            layer.frame = AVplayerView.bounds
//            AVplayerView.layer.addSublayer(layer)
//            player.play()
//        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
