//
//  BaseVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 29/07/22.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        let button = UIButton(type: .custom)
        button.setImage(ImageAsset.backButton.systemAsset, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        button.tintColor = .white
        let leftbarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftbarButton
    }
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func performNavigation(controller : UIViewController){
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
