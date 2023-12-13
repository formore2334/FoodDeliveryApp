//
//  CustomTabBarContainer.swift
//  OrderApp
//
//  Created by ForMore on 12/12/2023.
//

import UIKit


class CustomTabBarContainer: UIView {
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.layer.opacity = 0.9
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private var singleDigitNumberConstraints: [NSLayoutConstraint] = []
    
    private var twoDigitNumberConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = min(circleView.bounds.width, circleView.bounds.height) / 2
    }
    
    private func setup() {
        addSubview(circleView)
        addSubview(numberLabel)
        
        setConstraints()
    }
    
    
    // MARK: - Configurations
    
    func configureLabel(with count: Int) {
        numberLabel.text = "\(count)"

        // Apply needs layout to label base on count value
        if count > 0 && count < 10 {
            NSLayoutConstraint.deactivate(twoDigitNumberConstraints)
            NSLayoutConstraint.activate(singleDigitNumberConstraints)
            
            circleView.isHidden = false
            numberLabel.isHidden = false
        } else if count >= 10 && count < 100 {
            NSLayoutConstraint.deactivate(singleDigitNumberConstraints)
            NSLayoutConstraint.activate(twoDigitNumberConstraints)
            
            circleView.isHidden = false
            numberLabel.isHidden = false
        } else {
            circleView.isHidden = true
            numberLabel.isHidden = true
        }
    }

    // MARK: - Constraints
    
    private func setConstraints() {
        
        singleDigitNumberConstraints = [

            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -38),
           // numberLabel.trailingAnchor.constraint(equalToC: widthAnchor / 2),

            circleView.heightAnchor.constraint(equalTo: numberLabel.heightAnchor, multiplier: 1.2),
            circleView.widthAnchor.constraint(equalTo: numberLabel.heightAnchor, multiplier: 1.25),
            circleView.centerXAnchor.constraint(equalTo: numberLabel.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
        ]
        
        twoDigitNumberConstraints = [
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),

            circleView.heightAnchor.constraint(equalTo: numberLabel.heightAnchor, multiplier: 1.25),
            circleView.widthAnchor.constraint(equalTo: numberLabel.widthAnchor, multiplier: 1.4),
            circleView.centerXAnchor.constraint(equalTo: numberLabel.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
        ]
        
    }
    
}
