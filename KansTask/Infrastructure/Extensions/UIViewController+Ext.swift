//
//  UIView+Ext.swift
//  KansTask
//
//  Created by Kareem Abd El Sattar on 19/01/2024.
//

import UIKit

extension UIViewController {
    func applyCornerToViews(view: UIView, radius: CGFloat, corners: CACornerMask) {
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = corners
    }
}
