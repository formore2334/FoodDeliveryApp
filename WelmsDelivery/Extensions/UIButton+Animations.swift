//
//  UIButton+Animations.swift
//  OrderApp
//
//  Created by ForMore on 06/12/2023.
//

import UIKit

extension UIButton {
    func scaleAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.1
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = 1

        layer.add(scaleAnimation, forKey: "buttonPress")
    }
}
