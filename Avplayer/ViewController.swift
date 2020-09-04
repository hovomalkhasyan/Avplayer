//
//  ViewController.swift
//  Avplayer
//
//  Created by Hovo on 9/3/20.
//  Copyright © 2020 Hovo. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class ViewController: UIViewController {
    let player = AVPlayer()
    let videoArray = ["https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148817616325109_cropped.mp4","https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148817214585222_cropped.mp4","https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148816379670003_cropped.mp4","https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815787535811_cropped.mp4", "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815250094987_cropped.mp4", "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148809444612265_cropped.mp4"]
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetups()

    }
    private func tableViewSetups() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AVCell", for: indexPath) as! AVCell
//
//        let videoURL = URL(string: videoArray[indexPath.row])
//        let player = AVPlayer(url: videoURL!)
//        let layer = AVPlayerLayer(player: player)
//        layer.frame = cell.bounds
//        cell.layer.addSublayer(layer)
//        player.play()
//
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? AVCell else {return}
//            cell.videoLayer.player?.play()
        print("Video is stoped")
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
   
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let cells = tableView.visibleCells
//        for value in cells {
//
//            if let cell = value as? AVCell {
//                if cell.videoLayer.bounds.origin.y == view.bounds.origin.y/2 {
//                    cell.videoLayer.player?.play()
//                } else {
//                    cell.videoLayer.player?.pause()
//                }
//            }
//        }
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, indexPathsForVisibleRows.count > 0 {
                var focusCell: AVCell?

                for indexPath in indexPathsForVisibleRows {
                    if let cell = tableView.cellForRow(at: indexPath) as? AVCell {
                        if focusCell == nil {
                            let rect = tableView.rectForRow(at: indexPath)
                            if tableView.bounds.contains(rect) {
                                cell.videoLayer.player?.play()
                                focusCell = cell
                            } else {
                                 cell.videoLayer.player?.pause()
                            }
                        } else {
                             cell.videoLayer.player?.pause()
                        }
                    }
                }
            }
        }
}
