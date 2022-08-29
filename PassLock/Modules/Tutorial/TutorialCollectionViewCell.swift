//
//  TutorialCollectionViewCell.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 29/07/22.
//

import UIKit

class TutorialCollectionViewCell:
    UICollectionViewCell {
    @IBOutlet private(set) weak var tutorialImage: UIImageView!
    @IBOutlet private(set) weak var tutorialLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(labelText : String) {
        tutorialLabel.text = labelText
    }
}
