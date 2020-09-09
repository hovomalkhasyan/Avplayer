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
    var videoLayer = AVPlayerLayer()
    var playerItem: AVPlayerItem?
    var videoURL : URL?
    var player = AVPlayer()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.speakerButtonOutlet.alpha = 0
        }
        buttonOutlet.alpha = 0
    }
    
    func createPlayer() {
        let asset = AVAsset(url: videoURL!)
        playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        videoLayer.player = player
        videoLayer.frame = avPlayerView.bounds
        videoLayer.videoGravity = .resizeAspectFill
        avPlayerView.backgroundColor = .black
        avPlayerView.layer.addSublayer(videoLayer)
        
        player.play()
        stoppdPlayer()
        
    }
    
    func getThumbnailFromImage(url: URL, completion: @escaping ((_ image: UIImage?) -> Void )) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbilTime = CMTimeMake(value: 7, timescale: 1)
            
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbilTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func download() {
        let downloadTask = URLSession.shared.downloadTask(with: videoURL!) {
            urlOrNil, responseOrNil, errorOrNil in
            
            guard let fileURL = urlOrNil else { return }
            do {
                let documentsURL = try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
            } catch {
                print ("file error: \(error)")
            }
            print("response url is \(String(describing: responseOrNil?.url))")
        }
        downloadTask.resume()
    }
    
    private func stoppdPlayer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasStopd))
        avPlayerView.addGestureRecognizer(tap)
    }
    
    @objc func wasStopd() {
        UIView.animate(withDuration: 1) {
            self.buttonOutlet.alpha = 1
            self.speakerButtonOutlet.alpha = 1
        }
  
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
