//
//  ShakeButton.swift
//  OrderApp
//
//  Created by ForMore on 23/11/2023.
//

import UIKit


class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupButton() {
        setTitleColor(.white, for: .normal)

        backgroundColor = .red
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        setShadow()
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    public func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    public func press() {
        scaleAnimation(isEnabled: false)
    }
    
    public func pressWithEnable() {
        scaleAnimation(isEnabled: true)
    }
    
    private func scaleAnimation(isEnabled: Bool) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.1
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = 1
        
        if isEnabled {
            scaleAnimation.delegate = self
        }

        layer.add(scaleAnimation, forKey: "buttonPress")
    }
    
}

//MARK: - Enable button

extension CustomButton: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isEnabled = !flag
        layer.opacity = 0.7
        setTitleColor(.lightGray, for: .disabled)

    }
}
