//
//  SideMenuTableViewCell.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 03/08/22.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet private(set) weak var iconImage: UIImageView!
    @IBOutlet private(set) weak var titleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.iconImage.tintColor = .white
        self.titleText.textColor = .white
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(icon: UIImage, title: String) {
        iconImage.image = icon
        titleText.text = title
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = .lightGray
        selectedBackgroundView = myCustomSelectionColorView
    }
}
