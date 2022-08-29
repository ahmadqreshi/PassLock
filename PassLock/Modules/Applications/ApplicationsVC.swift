//
//  ApplicationsVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 03/08/22.
//

import UIKit
import MotionToastView

class ApplicationsVC: BaseVC {
    @IBOutlet weak var applicationTableView: UITableView!
    var expandedIndexSet : IndexSet = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableViewCell()
        reloadClosure = {
            self.applicationTableView.reloadData()
        }
    }
    func setUpTableViewCell() {
        applicationTableView.delegate = self
        applicationTableView.dataSource = self
        applicationTableView.registerCell(cellIdentifier: ApplicationTableViewCell.identifier)
    }
}
private extension ApplicationsVC {
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {
        let controller = revealViewController()
        controller?.revealSideMenu()
    }
    @IBAction func addAppButtonPressed(_ sender: UIButton) {
        let controller = AddAppVC.instantiate(fromAppStoryboard: .postlogin)
        self.navigationController?.present(controller, animated: true)
    }
}
extension ApplicationsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.selectedApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.identifier, for: indexPath) as? ApplicationTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.selectionStyle = .none
        cell.configure(AppData.shared.selectedApps[indexPath.row])
        if self.expandedIndexSet.contains(indexPath.row) {
            cell.lowerView.isHidden  = false
        } else {
            cell.lowerView.isHidden  = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            expandedIndexSet.insert(indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
extension ApplicationsVC : CellButtonCalls {
    
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
//            if let url = URL(string: "itms-apps://apple.com/app/") {
//                UIApplication.shared.open(url)
//            }
        }
    }
    func navigateToWebVC(weblink: String?) {
        if weblink == nil {
            MotionToast(message: "Sorry link can not be open", toastType: .warning, duration: .short, toastStyle: .style_vibrant, toastGravity: .top, toastCornerRadius: 5, pulseEffect: false)
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
        applicationTableView.beginUpdates()
        applicationTableView.deleteRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        applicationTableView.endUpdates()
    }
    func editButtonPressed() {
    }
}
