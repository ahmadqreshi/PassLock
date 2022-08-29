//
//  ViewController.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 29/07/22.
//

import UIKit

class TutorialVC: BaseVC {
    @IBOutlet private(set) weak var tutorialCollectionView: UICollectionView!
    @IBOutlet private(set) weak var tutorialPageControl: UIPageControl!
    var currentPage = 0 {
        didSet {
            tutorialPageControl.currentPage = currentPage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialPageControl.numberOfPages = StringConstant.TutorialLabels.allCases.count
        UserDefaults.standard.set(true, forKey: "isTutorialDisplated")
    }
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        let controller = IntroVC.instantiate(fromAppStoryboard: .prelogin)
        performNavigation(controller: controller)
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if currentPage == tutorialPageControl.numberOfPages - 1 {
            let controller = IntroVC.instantiate(fromAppStoryboard: .prelogin)
            performNavigation(controller: controller)
        } else {
            currentPage += 1
            tutorialCollectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
extension TutorialVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StringConstant.TutorialLabels.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstant.CollectionViewIdentifiers.tutorialCollectionViewCell.rawValue, for: indexPath) as? TutorialCollectionViewCell else { return UICollectionViewCell()}
        cell.configureCell(labelText: StringConstant.TutorialLabels.allCases[indexPath.row].rawValue)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        tutorialPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        currentPage = tutorialPageControl.currentPage
    }
}
