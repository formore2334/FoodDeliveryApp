//
//  DetailCouponInfoViewController.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import UIKit

class DetailCouponInfoViewController: UIViewController {

    var coupon: Coupon
    
    //MARK: - Set varibles
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.backgroundColor = .systemGray3
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let promoLabel: UILabel = {
        let label = UILabel()
        label.text = "Promo:"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    let discountBlurContainerView: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 7
        container.backgroundColor = .clear
        container.clipsToBounds = true
        return container
    }()
    
    var discountBlurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: .regular)
        blurView.alpha = 0.96
        return blurView
    }()
    
    //MARK: - Initialization
    
    init(coupon: Coupon) {
        self.coupon = coupon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
       
    }
    
    //MARK: - Configurations
    
    private func configureVC() {
        let backgroundBlurEffect = UIBlurEffect(style: .extraLight)
        let backgroundBlurView = UIVisualEffectView(effect: backgroundBlurEffect)
        
        backgroundBlurView.frame = view.bounds
        view.backgroundColor = .clear
        
        view.addSubview(backgroundBlurView)
        view.addSubview(titleLabel)
        view.addSubview(promoLabel)
        view.addSubview(discountLabel)
        
        titleLabel.text = coupon.description
        discountLabel.text = coupon.discountKeyWord
        
        setDiscountBlurView()
        blurViewGestureRecognizer()
        
        setConstraints()
    }
    
    private func setDiscountBlurView() {
    
        view.addSubview(discountBlurContainerView)
        discountBlurContainerView.addSubview(discountBlurView)
        
       setBlurViewConstraints()
    }
    
    //MARK: - Handle tap gesture in Blur View
    
    private func blurViewGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

        discountBlurView.addGestureRecognizer(tapGestureRecognizer)
        discountBlurView.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        removeBlurAnimationAndText()
    }
    
    private func removeBlurAnimationAndText() {
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
            self.discountBlurView.effect = nil
            self.promoLabel.alpha = 0
        }
        animator.startAnimation()
    }

    
    //MARK: - Constraints
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            promoLabel.centerYAnchor.constraint(equalTo: discountLabel.centerYAnchor),
            promoLabel.trailingAnchor.constraint(equalTo: discountLabel.leadingAnchor),
            
            discountLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            discountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // Only Blur constraits
    private func setBlurViewConstraints() {
        discountBlurContainerView.translatesAutoresizingMaskIntoConstraints = false
        discountBlurView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            discountBlurContainerView.topAnchor.constraint(equalTo: discountLabel.topAnchor),
            discountBlurContainerView.leadingAnchor.constraint(equalTo: discountLabel.leadingAnchor),
            discountBlurContainerView.trailingAnchor.constraint(equalTo: discountLabel.trailingAnchor),
            discountBlurContainerView.bottomAnchor.constraint(equalTo: discountLabel.bottomAnchor),
            
            discountBlurView.topAnchor.constraint(equalTo: discountBlurContainerView.topAnchor),
            discountBlurView.leadingAnchor.constraint(equalTo: discountBlurContainerView.leadingAnchor),
            discountBlurView.trailingAnchor.constraint(equalTo: discountBlurContainerView.trailingAnchor),
            discountBlurView.bottomAnchor.constraint(equalTo: discountBlurContainerView.bottomAnchor)
        ])
    }

}
