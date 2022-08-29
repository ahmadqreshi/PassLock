//
//  ApplicationTableViewCell.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 04/08/22.
//

import UIKit
import MotionToastView
protocol CellButtonCalls : AnyObject {
    func navigateToWebVC(weblink : String?)
    func navigateToAnotherApp(appLink : String?, appName : String)
    func navigateToShowDetails(appName : String)
    func deleteButtonPressed(indexAt : Int)
    func editButtonPressed()
    
}
class ApplicationTableViewCell: UITableViewCell {
    class var identifier : String { return String(describing: self)}
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var favButton : UIButton!
    @IBOutlet weak var dropDownView: UIView!
    weak var delegate : CellButtonCalls?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        dropDownView.isHidden = true
        sender.cancelsTouchesInView = false
    }
    func configure(_ data : AppDetailModel) {
        if let colorName = data.color {
            upperView.backgroundColor = UIColor(named: colorName)
            lowerView.backgroundColor = UIColor(named: colorName)
        }
        favButton.isSelected = data.isFav ? true : false
        appIcon.image = UIImage(named: data.name) ?? UIImage(named: "Others")
        appName.text = data.name
    }
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        guard let index = AppData.shared.selectedApps.firstIndex(where: {$0.name == appName.text ?? ""}) else { return }
        AppData.shared.selectedApps[index].isFav.toggle()
    }
    @IBAction func openButtonsPressed(_ sender: UIButton) {
        guard let index = AppData.shared.selectedApps.firstIndex(where: {$0.name == appName.text ?? ""}) else { return }
        switch sender.tag {
        case 1 :
            delegate?.navigateToAnotherApp(appLink: "instagram://user?username=johndoe", appName: AppData.shared.selectedApps[index].name)
        case 2 :
            delegate?.navigateToWebVC(weblink: AppData.shared.selectedApps[index].webLink)
        default :
            return
            
        }
    }
    @IBAction func showInfoButtonPressed(_ sender: UIButton) {
        debugPrint("Show info Pressed")
        guard let index = AppData.shared.selectedApps.firstIndex(where: {$0.name == appName.text ?? ""}) else { return }
        delegate?.navigateToShowDetails(appName: AppData.shared.selectedApps[index].name)
    }
    @IBAction func moreOptionButtonPressed(_ sender: UIButton) {
        self.dropDownView.isHidden.toggle()
    }
    @IBAction func deleteOrEditButtonsPressed(_ sender: UIButton) {
        guard let index = AppData.shared.selectedApps.firstIndex(where: {$0.name == appName.text ?? ""}) else { return }
        switch sender.tag {
        case 1 : debugPrint("Delete")
            delegate?.deleteButtonPressed(indexAt: index)
        case 2 : debugPrint("Edit")
            delegate?.editButtonPressed()
        default :
            return
        }
    }
}
