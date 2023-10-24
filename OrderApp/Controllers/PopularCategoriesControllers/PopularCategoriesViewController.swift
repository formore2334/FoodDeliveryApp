//
//  ViewController.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class PopularCategoriesViewController: UIViewController {

    private var collectionView: UICollectionView?

    private let menu: [Menu] = Menu.mockData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }

    
    //MARK: - Configure PopularCategories vc
    
    private func configureVC() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection())
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        setConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PopularCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoriesCollectionViewCell.identifier)
        collectionView.register(PopularCategoriesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PopularCategoriesHeaderCollectionReusableView.idintifier)
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

// MARK: - Delegat's

extension PopularCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped me")
        let categoryDetailVC = CategoryDetailMenuViewController(menu: menu[indexPath.row])
        
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
    
}

extension PopularCategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoriesCollectionViewCell.identifier, for: indexPath) as! PopularCategoriesCollectionViewCell
        
        cell.configure(imageName: menu[indexPath.row].imageName, title: menu[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PopularCategoriesHeaderCollectionReusableView.idintifier, for: indexPath) as! PopularCategoriesHeaderCollectionReusableView

        header.configure()
        return header
    }  
}

extension PopularCategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
}
