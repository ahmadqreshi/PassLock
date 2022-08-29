//
//  NumbersCollectionViewCell.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 08/08/22.
//

import UIKit

class NumbersCollectionViewCell: UICollectionViewCell {
    class var identifier : String { return String(describing: self) }
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func layoutSubviews() {
        layoutIfNeeded()
        self.contentView.cornerRadius = self.contentView.bounds.width/2
    }
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    func fillNumber(row : Int ){
        switch row {
        case 9 :
            numberLabel.text = String()
            contentView.borderWidth = 0
        case 10 :
            numberLabel.text = "0"
        case 11 :
            numberLabel.text = String()
            contentView.borderWidth = 0
            imageView.isHidden = false
        default:
            numberLabel.text = "\(row + 1)"
        }
    }
    private func shrink(down: Bool) {
        if down {
            UIView.animate(withDuration: 0.1) {
                self.contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.contentView.backgroundColor = UIColor(named: "lightBlue")
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = .identity
                self.contentView.backgroundColor = .clear
            }
            
        }
    }
}
