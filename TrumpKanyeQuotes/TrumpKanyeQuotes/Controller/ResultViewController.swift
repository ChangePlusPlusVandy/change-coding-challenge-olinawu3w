//
//  ResultViewController.swift
//  TrumpElonTweets
//
//  Created by apple on 2020/9/21.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var score = 0
    
    var comment: String {
        switch score {
        case 0...5:
            return "**You can do better!!!"
        case 6...7:
            return "**Not bad!!!"
        case 8...9:
            return "**Almost perfect!!!"
        case 10:
            return "**You know these two better than they know themselves! :O"
        default:
            return "**Does not reconize your score."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        commentLabel.text  = comment
    }
}
