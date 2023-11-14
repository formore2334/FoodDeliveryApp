//
//  ViewController.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class PopularCategoriesViewController: UICollectionViewController {
    
    var coordinator: MainCoordinator?
    
    private let menu: [Menu] = Menu.mockData.shuffled()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Best of Week"
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
        
        collectionView.register(PopularCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoriesCollectionViewCell.identifier)
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
           
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            
        ])
    }
}

extension PopularCategoriesViewController {
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoriesCollectionViewCell.identifier, for: indexPath) as! PopularCategoriesCollectionViewCell

        cell.configure(imageName: menu[indexPath.row].imageName, title: menu[indexPath.row].title)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryDetailVC = CategoryDetailMenuViewController(menu: menu[indexPath.row], coordinator: coordinator)
        
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }

}

extension PopularCategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 56)
    }
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return layout
    }
    
}
