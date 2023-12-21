//
//  CouponViewController.swift
//  OrderApp
//
//  Created by ForMore on 22/11/2023.
//

import UIKit

class CouponViewController: UICollectionViewController {
    
    private let coupons: [Coupon] = DataService.shared.coupons
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coupons"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureVC()
    }
    
    private func configureVC() {
        view.addSubview(titleLabel)
        collectionView.register(CouponCell.self, forCellWithReuseIdentifier: CouponCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layoutCollection()
        
        setConstraints()
    }
    
    
    
   //MARK: - Constraints
     
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

extension CouponViewController {
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupons.count
    }
    
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CouponCell.identifier, for: indexPath) as! CouponCell
        
        cell.configure(stringURL: coupons[indexPath.row].imageURL, title: coupons[indexPath.row].title)
        return cell
    }

   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

       let detailCouponInfoVC = DetailCouponInfoViewController(coupon: coupons[indexPath.row])
    
       if let sheet = detailCouponInfoVC.sheetPresentationController {
           sheet.detents = [.custom(resolver: { context in
               0.13 * context.maximumDetentValue
           })]
           sheet.prefersGrabberVisible = true
           sheet.preferredCornerRadius = 25
       }

       navigationController?.present(detailCouponInfoVC, animated: true)
    }

}

extension CouponViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 130)
    }
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        
        return layout
    }
    
}
