//
//  DetailCouponInfoViewController.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import UIKit

final class CouponReviewViewController: UIViewController {

    var coupon: Coupon
    
    //MARK: - Set varibles
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.backgroundColor = .systemGray3
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var promoLabel: UILabel = {
        let label = UILabel()
        label.text = "Promo:"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var blurContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 7
        container.backgroundColor = .clear
        container.clipsToBounds = true
        return container
    }()
    
    private lazy var discountBlurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: .regular)
        blurView.alpha = 0.96
        return blurView
    }()
    
    //MARK: - Init
    
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
        
        // Sets blur effect for vc background
        let backgroundBlurEffect = UIBlurEffect(style: .extraLight)
        let backgroundBlurView = UIVisualEffectView(effect: backgroundBlurEffect)
        
        backgroundBlurView.frame = view.bounds
        
        // Cleared view background to correctly display blur effect
        view.backgroundColor = .clear
        
        view.addSubview(backgroundBlurView)
        view.addSubview(titleLabel)
        view.addSubview(promoLabel)
        view.addSubview(discountLabel)
        
        titleLabel.text = coupon.description
        discountLabel.text = coupon.discountKeyWord
        
        // Sets one more blur effect to discount text
        setDiscountBlurView()
        blurViewGestureRecognizer()
        
        setConstraints()
    }
    
    // Sets blur view on the foreground of discount title to hide it
    private func setDiscountBlurView() {
        view.addSubview(blurContainer)
        blurContainer.addSubview(discountBlurView)
        
       setBlurViewConstraints()
    }
    
    //MARK: - Handle tap gesture in Blur View
    
    private func blurViewGestureRecognizer() {
        
        // Sets tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

        // Adds recognizer on the discountBlurView
        discountBlurView.addGestureRecognizer(tapGestureRecognizer)
        discountBlurView.isUserInteractionEnabled = true
    }
    
    // Sets tap gesture handling
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        removeBlurAnimationAndText()
    }
    
    // Removes blur from discount text
    private func removeBlurAnimationAndText() {
        
        // Configure animator
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
            self.discountBlurView.effect = nil
            self.promoLabel.alpha = 0
        }
        
        animator.startAnimation()
    }

}

//MARK: - Constraints

private extension CouponReviewViewController {

    func setConstraints() {
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
        blurContainer.translatesAutoresizingMaskIntoConstraints = false
        discountBlurView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurContainer.topAnchor.constraint(equalTo: discountLabel.topAnchor),
            blurContainer.leadingAnchor.constraint(equalTo: discountLabel.leadingAnchor),
            blurContainer.trailingAnchor.constraint(equalTo: discountLabel.trailingAnchor),
            blurContainer.bottomAnchor.constraint(equalTo: discountLabel.bottomAnchor),
            
            discountBlurView.topAnchor.constraint(equalTo: blurContainer.topAnchor),
            discountBlurView.leadingAnchor.constraint(equalTo: blurContainer.leadingAnchor),
            discountBlurView.trailingAnchor.constraint(equalTo: blurContainer.trailingAnchor),
            discountBlurView.bottomAnchor.constraint(equalTo: blurContainer.bottomAnchor)
        ])
    }
    
}
