//
//  SaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class SaleViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var collectionView: UICollectionView?
    
    private let sales: [Sale] = Sale.mockData
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        configureVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 400)
    }
    
    //MARK: - Configure PopularCategories vc
    
    private func configureVC() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection())
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        setConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.identifier)
        collectionView.register(SaleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SaleCollectionReusableView.idintifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
    }
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        
        return layout
    }
    
    
    //MARK: - Constraints
    func setConstraints() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension SaleViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailSaleVC = DetailSaleViewController(sale: sales[indexPath.row])
        
        navigationController?.pushViewController(detailSaleVC, animated: true)
    }
    
}

extension SaleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sales.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.identifier, for: indexPath) as! SaleCollectionViewCell
        
        cell.configure(imageName: sales[indexPath.row].imageName, title: sales[indexPath.row].title)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SaleCollectionReusableView.idintifier, for: indexPath) as! SaleCollectionReusableView
        
        header.configure()
        return header
    }
    
}

extension SaleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
}

