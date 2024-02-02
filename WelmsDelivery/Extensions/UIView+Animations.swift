//
//  UIView+Animations.swift
//  OrderApp
//
//  Created by ForMore on 24/11/2023.
//

import UIKit

extension CGAffineTransform {
    static func animateContentFlyIn(middleItem: UIView, firstItem: UIView, lastItem: UIView, superView: UIView) {
        let duration = 0.5

        // Set the initial position of the content offscreen to the right
        firstItem.transform = CGAffineTransform(translationX: superView.bounds.width, y: 0)
        middleItem.transform = CGAffineTransform(translationX: superView.bounds.width, y: 0)
        lastItem.transform = CGAffineTransform(translationX: superView.bounds.width, y: 0)

        // Animate the content back to its original position
        UIView.animate(withDuration: duration, delay: 0, options: .transitionCurlDown, animations: {
            middleItem.transform = .identity
        }, completion: nil)

        UIView.animate(withDuration: duration, delay: 0.2, options: .curveEaseOut, animations: {
            firstItem.transform = .identity
            lastItem.transform = .identity
        }, completion: nil)
    }
}


extension UIView {
    func startBlinkingAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.alpha = 0.5
        }, completion: nil)
    }
    
    func stopBlinkingAnimation() {
        self.alpha = 1.0
        self.layer.removeAllAnimations()
    }

}
