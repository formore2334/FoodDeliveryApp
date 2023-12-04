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
        startGradientAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        let topColor = UIColor.red.cgColor
        let bottomColor = UIColor.yellow.cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        
        let radius = min(bounds.width, bounds.height) / 2
        let startPoint = CGPoint(x: 0.0, y: 0.6)
        let endPoint = CGPoint(x: 0.4, y: 0.8)
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        maskLayer.path = path.cgPath
        
        gradientLayer.mask = maskLayer
        
        layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = radius
    }
    
    private func setupButton() {
        setTitle("Special!", for: .normal)
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func startPulsatingAnimation() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        layer.add(pulseAnimation, forKey: "pulsating")
    }
    
    private func startGradientAnimation() {
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.duration = 0.5
        gradientAnimation.fromValue = [0.0, 1.0]
        gradientAnimation.toValue = [1.0, 0.0]
        gradientAnimation.autoreverses = true
        gradientAnimation.repeatCount = .infinity
        
        guard let gradientLayer = layer.sublayers?.first as? CAGradientLayer else { return }
        gradientLayer.add(gradientAnimation, forKey: "gradientAnimation")
    }
    
}






