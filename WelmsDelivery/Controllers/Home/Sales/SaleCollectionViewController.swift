//
//  SaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

final class SaleCollectionViewController: UICollectionViewController, Coordinating {
    
    private let salesManager: SalesManager
    
    var coordinator: MainCoordinator?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sales"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Init
    
    init(salesManager: SalesManager = SalesManager(sales: DataService.shared.sales),
         coordinator: MainCoordinator? = nil) {
        self.salesManager = salesManager
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
    
    // MARK: - Configurations
    
    private func configureVC() {
        view.addSubview(titleLabel)
        
        collectionView.register(SaleCollectionViewCell.self,
                                forCellWithReuseIdentifier: SaleCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layoutCollection()
        
        setConstraints()
    }
    
}

//MARK: - Constraints

private extension SaleCollectionViewController {
    
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

extension SaleCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return salesManager.sales.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.identifier,
                                                      for: indexPath) as! SaleCollectionViewCell
        
        let stringURL = salesManager.sales[indexPath.row].previewImageURL
        let title = salesManager.sales[indexPath.row].title
        
        cell.configure(stringURL: stringURL, title: title)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sale = salesManager.sales[indexPath.row]
        
        let saleInfoVC = SaleInfoViewController(sale: sale,
                                                    salesManager: salesManager,
                                                    coordinator: coordinator)
        
        navigationController?.pushViewController(saleInfoVC, animated: true)
    }
    
}

// MARK: - Layout

extension SaleCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
    
    // Sets layout model to vc
    private func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        
        return layout
    }
    
}
