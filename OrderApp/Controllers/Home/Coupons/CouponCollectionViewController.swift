//
//  CouponViewController.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import UIKit

class CouponCollectionViewController: UICollectionViewController {
    
    private let coupons: [Coupon]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coupons"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Init
    
    init(coupons: [Coupon] = DataService.shared.coupons) {
        self.coupons = coupons
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    // MARK: - Configurations
    
    private func configureVC() {
        view.addSubview(titleLabel)
        
        collectionView.register(CouponCollectionViewCell.self,
                                forCellWithReuseIdentifier: CouponCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layoutCollection()
        
        setConstraints()
    }
    
}

//MARK: - Constraints

private extension CouponCollectionViewController {
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
}

// MARK: - DataSource

extension CouponCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupons.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CouponCollectionViewCell.identifier,
                                                      for: indexPath) as! CouponCollectionViewCell
        
        let stringURL = coupons[indexPath.row].imageURL
        let title = coupons[indexPath.row].title
        
        cell.configure(stringURL: stringURL, title: title)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let coupon = coupons[indexPath.row]
        
        let couponReviewVC = CouponReviewViewController(coupon: coupon)
        
        // Makes sheet presentation of the next vc
        if let sheet = couponReviewVC.sheetPresentationController {
            
            // Sets dynamic size to sheet presentation
            sheet.detents = [.custom(resolver: { context in
                0.13 * context.maximumDetentValue
            })]
            
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 25
        }
        
        navigationController?.present(couponReviewVC, animated: true)
    }
    
}

// MARK: - Layout

extension CouponCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 130)
    }
    
    // Sets layout model to vc
    private func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        
        return layout
    }
    
}
