//
//  UIView+Ext.swift
//  KansTask
//
//  Created by Kareem Abd El Sattar on 19/01/2024.
//

import UIKit

extension UIView {
    func applyShadow() {
        self.layer.shadowColor = UIColor.main.cgColor
        self.layer.shadowOpacity = 0.7 // You can adjust this value
        self.layer.shadowOffset = CGSize(width: 0, height: 10) // Modify this as needed
        self.layer.shadowRadius = 15 // Increase or decrease the blur radius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
