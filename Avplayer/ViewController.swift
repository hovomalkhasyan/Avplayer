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
    //MARK: Properties
    let videoArray = ["https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148817616325109_cropped.mp4",
                      "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148817214585222_cropped.mp4",
                      "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148816379670003_cropped.mp4",
                      "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815787535811_cropped.mp4",
                      "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815250094987_cropped.mp4",
                      "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148809444612265_cropped.mp4"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetups()
    }
    
    private func tableViewSetups() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = self.view.bounds.height / 2
        tableView.separatorStyle = .none

    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AVCell", for: indexPath) as! AVCell
        let stringUrl = videoArray[indexPath.row]
        UIView.animate(withDuration: 2, delay: 0.5, options: .beginFromCurrentState, animations: {
            cell.videoURL = URL(string: stringUrl)
            cell.createPlayer()
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height / 2
    }
    
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
                             cell.buttonOutlet.setImage(UIImage(named: "pause"), for: .normal)
                        }
                    } else {
                        cell.videoLayer.player?.pause()
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
        print("ok")
    }
}
