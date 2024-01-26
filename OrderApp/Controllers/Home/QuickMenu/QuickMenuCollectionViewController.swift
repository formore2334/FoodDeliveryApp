//
//  ViewController.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class QuickMenuCollectionViewController: UICollectionViewController, Coordinating {
    
    private let menu: [Menu]
    
    var coordinator: MainCoordinator?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Init
    
    init(menu: [Menu] = DataService.shared.menu,
         coordinator: MainCoordinator? = nil) {
        self.menu = menu
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
    
    //MARK: - Configurations
    
    private func configureVC() {
        view.addSubview(titleLabel)
        
        collectionView.register(QuickMenuCollectionViewCell.self,
                                forCellWithReuseIdentifier: QuickMenuCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layoutCollection()
        
        setConstraints()
    }
    
}

//MARK: - Constraints

private extension QuickMenuCollectionViewController {
    
    private func setConstraints() {
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

// MARK: - DataSource

extension QuickMenuCollectionViewController {
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickMenuCollectionViewCell.identifier,
                                                      for: indexPath) as! QuickMenuCollectionViewCell
        
        let imageName = menu[indexPath.row].imageName
        let title = menu[indexPath.row].title
        
        cell.configure(imageName: imageName, title: title)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menu = menu[indexPath.row]
        
        let menuCategoryVC = MenuCategoryCollectionViewController(menu: menu, coordinator: coordinator)
        
        // Makes custom transition to the next vc
        UIView.transition(with: navigationController!.view,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            self.navigationController?.pushViewController(menuCategoryVC, animated: false)
        }, completion: nil)

    }

}

// MARK: - Layout

extension QuickMenuCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 56)
    }
    
    // Sets layout model to vc
    private func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return layout
    }
    
}
