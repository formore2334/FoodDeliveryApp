//
//  SaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class SaleViewController: UICollectionViewController {
    
    var coordinator: MainCoordinator?
    
    private let salesManager = SalesManager()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sales"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    init(coordinator: MainCoordinator? = nil) {
        self.coordinator = coordinator
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
        collectionView.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.identifier)
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

extension SaleViewController {
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return salesManager.sales.count
    }
    
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.identifier, for: indexPath) as! SaleCollectionViewCell
        
       cell.configure(stringURL: salesManager.sales[indexPath.row].previewImageURL, title: salesManager.sales[indexPath.row].title)
        return cell
    }
    
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let detailSaleVC = DetailSaleViewController(sale: salesManager.sales[indexPath.row], coordinator: coordinator)
        
        navigationController?.pushViewController(detailSaleVC, animated: true)
    }
    
}

extension SaleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        
        return layout
    }
    
}

