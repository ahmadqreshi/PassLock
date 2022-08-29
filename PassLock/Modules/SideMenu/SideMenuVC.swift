//
//  SideMenuVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 03/08/22.
//

import UIKit
protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}
class SideMenuVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sideMenuTableView: UITableView!
    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "apps.iphone")!, title: "Applications"),
        SideMenuModel(icon: UIImage(systemName: "star.fill")!, title: "Favourites"),
        SideMenuModel(icon: UIImage(systemName: "pencil.and.outline")!, title: "Edit Profile"),
        SideMenuModel(icon: UIImage(systemName: "arrow.counterclockwise")!, title: "Log Out"),
        SideMenuModel(icon: UIImage(systemName: "hand.thumbsup.fill")!, title: "Like us")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.separatorStyle = .none
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        
        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuTableViewCell.nib, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        
        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource and Delegate
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as? SideMenuTableViewCell else { return UITableViewCell() }
        cell.configureCell(icon: self.menu[indexPath.row].icon, title: self.menu[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
        if indexPath.row == 4 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

