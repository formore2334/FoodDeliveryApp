//
//  MenuViewController.swift
//  OrderApp
//
//  Created by ForMore on 28/10/2023.
//

import UIKit

final class MenuCollectionViewController: UICollectionViewController, Coordinating {
    
    let menu: [Menu]
    
    var coordinator: MainCoordinator?
    
    // MARK: - Init
    
    init(menu: [Menu] = DataService.shared.menu,
         coordinator: MainCoordinator? = nil) {
        self.menu = menu
        self.coordinator = coordinator
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogo()
        configureVC()
    }
    
    //MARK: - Configurations
    
    // Sets logo to nav bar pannel
    private func configureLogo() {
        guard let navigationController = navigationController else { return }
        
        let logoView = LogoView()
        logoView.configureIntoNavBar(in: navigationController, with: navigationItem)
    }
    
    // Configure vc
    private func configureVC() {
        collectionView.register(MenuCollectionViewCell.self,
                                forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        
        collectionView.register(MenuCollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MenuCollectionViewHeader.identifier)
        
        collectionView.collectionViewLayout = layoutCollection()
        
        setBackgroundImage()
    }
    
    // Sets background image to vc
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundFullImage"))
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.opacity = 0.3
        
        collectionView.backgroundView = backgroundImageView
    }
    
}


//MARK: - Data Source

extension MenuCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menu.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu[section].menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier,
                                                      for: indexPath) as! MenuCollectionViewCell
        
        let menuItem = menu[indexPath.section].menuItems[indexPath.item]
        
        cell.configure(menuItem: menuItem)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: MenuCollectionViewHeader.identifier,
                                                                         for: indexPath) as! MenuCollectionViewHeader
        
        headerView.titleLabel.text = menu[indexPath.section].title
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menuItem = menu[indexPath.section].menuItems[indexPath.item]
        let menuTitle = menu[indexPath.section].title
        
        let menuItemReviewVC = MenuItemReviewViewController(menuItem: menuItem,
                                                            menuTitle: menuTitle,
                                                            coordinator: coordinator)
        
        navigationController?.pushViewController(menuItemReviewVC, animated: true)
    }
    
}

//MARK: - Layout

extension MenuCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    // Sets layout model to vc
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 100, right: 20)
        layout.minimumLineSpacing = 90
        
        return layout
    }
    
}
