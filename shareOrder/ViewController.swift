//
//  ViewController.swift
//  shareOrder
//
//  Created by Vikas Vaish on 23/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainHeightConstraint: NSLayoutConstraint!
    @IBOutlet var showMoreButton: UIButton!
    @IBOutlet weak var mainTableview: UITableView!
    private var shouldCollapse = false
    var buttonTitle: String {
        return shouldCollapse ? "Show Less" : "Show More"
    }

    struct Constant {
        static let estimatedHeightRow = 100.0
        static let estimatedHeaderHeight = 100.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableview.delegate = self
        mainTableview.dataSource = self
                    
//        self.mainTableview.register(nibName, forHeaderFooterViewReuseIdentifier: ProfileSectionView.reusableId)
        mainTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        mainTableview.estimatedRowHeight = Constant.estimatedHeightRow
//        mainTableview.estimatedSectionHeaderHeight = Constant.estimatedHeaderHeight
        mainTableview.sectionHeaderTopPadding = 0.0
        // Do any additional setup after loading the view.
    }

   

    @IBAction func buttonTap(_ sender: Any) {
        if shouldCollapse {
            animateView(isCollapse: false,
                        buttonText: buttonTitle,
                        heighConstraint: 0)
        } else {
            animateView(isCollapse: true,
                        buttonText: buttonTitle,
                        heighConstraint: 124)
            
        }
    }
    
    private func animateView(isCollapse: Bool,
                             buttonText: String,
                             heighConstraint: Double) {
        shouldCollapse = isCollapse
        mainHeightConstraint.constant = CGFloat(heighConstraint)
        showMoreButton.setTitle(buttonTitle, for: .normal)
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

}


extension ViewController:  UITableViewDelegate,UITableViewDataSource {
    
//    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileSectionView.reusableId) as? ProfileSectionView else{
//            return nil
//        }
//        headerView.delegate = self
//        return headerView
//    }
//    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: ProfileSectionViewDelegate {
    func reloadSection() {
        let sectionIndex = IndexSet(integer: 0)
        mainTableview.reloadSections(sectionIndex, with: .none)
    }
    
}
