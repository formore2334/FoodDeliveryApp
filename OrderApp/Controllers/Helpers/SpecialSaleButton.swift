//
//  SpecialSaleButton.swift
//  OrderApp
//
//  Created by ForMore on 01/12/2023.
//

import UIKit


class SpecialSaleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
        startPulsatingAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopPulsatingAnimation()
        print("Deinit")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradient()
    }
    
    private func setupButton() {
        setTitle("Special!", for: .normal)
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        setShadow()
    }
    
    func startPulsatingAnimation() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        layer.add(pulseAnimation, forKey: "pulsating")
    }
    
    func stopPulsatingAnimation() {
        layer.removeAnimation(forKey: "pulsating")
    }

    
    private func setShadow() {
        layer.shadowColor = UIColor.yellow.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }

    
    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemOrange.cgColor, UIColor.red.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 1.1, y: 0.3)
        gradientLayer.frame = bounds
        
        let radius = min(bounds.width, bounds.height) / 2
        gradientLayer.cornerRadius = radius
        
        // Insert the gradient layer at the bottom of the layer hierarchy
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}






