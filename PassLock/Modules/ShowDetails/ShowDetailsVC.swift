//
//  ShowDetailsVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 26/08/22.
//

import UIKit
import GLScratchCard


class ShowDetailsVC: UIViewController {
    @IBOutlet weak var scratchView: GLScratchCardImageView!
    var appName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        scratchView.lineType = .round
        scratchView.lineWidth = 60
        scratchView.benchMarkScratchPercentage = 20
    }
    @IBAction func crossButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
