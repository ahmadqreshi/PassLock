//
//  FavouriteVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 03/08/22.
//

import UIKit

class FavouriteVC: BaseVC {
    
    @IBOutlet private weak var favTableView : UITableView!
    var expandedIndexSet : IndexSet = []
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.registerCell(cellIdentifier: ApplicationTableViewCell.identifier)
    }
    
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {
        let controller = revealViewController()
        controller?.revealSideMenu()
    }
}
extension FavouriteVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.favAppDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.identifier, for: indexPath) as? ApplicationTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.favButton.isHidden = true
        cell.configure(AppData.shared.favAppDetails[indexPath.row])
        if expandedIndexSet.contains(indexPath.row) {
            cell.lowerView.isHidden  = false
        } else {
            cell.lowerView.isHidden  = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedIndexSet.contains(indexPath.row) {
            return 130
        } else {
            return 80
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
            tableView.beginUpdates()
            AppData.shared.selectedApps[indexPath.row].isFav = false
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandler(true)
        }
        deleteAction.image = ImageAsset.delete.asset
        deleteAction.backgroundColor = .white
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
extension FavouriteVC : CellButtonCalls {
    func navigateToAnotherApp(appLink: String?, appName : String) {
        guard let urlString = appLink else { return }
        let url = URL(string: urlString)!
        if UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        } else {
            let controller = WebVC.instantiate(fromAppStoryboard: .postlogin)
            controller.webLink = "https://apps.apple.com/in/app/\(appName.lowercased())/"
            performNavigation(controller: controller)
//            if let url = URL(string: "itms-apps://apple.com/app/id839686104") {
//                UIApplication.shared.open(url)
//            }
        }
    }
    func navigateToWebVC(weblink: String?) {
        if weblink == nil {
            MotionToast(message: "link can not be open", toastType: .warning)
        } else {
            debugPrint("Success")
            let controller = WebVC.instantiate(fromAppStoryboard: .postlogin)
            guard let urlString = weblink else { return }
            controller.webLink = urlString
            performNavigation(controller: controller)
        }
    }
    func navigateToShowDetails(appName: String) {
        debugPrint(appName)
        let controller = ShowDetailsVC.instantiate(fromAppStoryboard: .postlogin)
        self.present(controller, animated: true)
    }
    func deleteButtonPressed(indexAt: Int) {
        AppData.shared.selectedApps.remove(at: indexAt)
        favTableView.beginUpdates()
        favTableView.deleteRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        favTableView.endUpdates()
    }
    func editButtonPressed() {
    }
}
