//
//  ProfileSectionView.swift
//  shareOrder
//
//  Created by Vikas Vaish on 23/07/24.
//

import Foundation
import UIKit

protocol ProfileSectionViewDelegate : AnyObject{
    func reloadSection()
}

class ProfileSectionView: UITableViewHeaderFooterView {
    
//    @IBOutlet var firstView: UIView!
//    @IBOutlet var secondView: UIView!
    @IBOutlet var mainHeightConstraint: NSLayoutConstraint!
    @IBOutlet var showMoreButton: UIButton!
    static let reusableId = "ProfileSectionView"
    var shouldCollapse = false
    var superViewCompletion: (() -> Void)?
    weak var delegate: ProfileSectionViewDelegate?
    var buttonTitle: String {
        return shouldCollapse ? "Show Less" : "Show More"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(shouldCollapse)
        showMoreButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
    }
    
    
    @objc func didButtonTap() {
        if shouldCollapse {
            animateView(isCollapse: false,
                        buttonText: buttonTitle,
                        heighConstraint: 0)
        } else {
            animateView(isCollapse: true,
                        buttonText: buttonTitle,
                        heighConstraint: 100)
        }
        delegate?.reloadSection()
    }
    
    
    private func animateView(isCollapse: Bool,
                             buttonText: String,
                             heighConstraint: Double) {

        UIView.animate(withDuration: 0.5) {
            self.shouldCollapse = isCollapse
            self.mainHeightConstraint.constant = CGFloat(heighConstraint)
            self.showMoreButton.setTitle(self.buttonTitle, for: .normal)
            self.layoutIfNeeded()
            self.superViewCompletion?()
        }
    }
    
}
