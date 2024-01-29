//
//  SecondViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

// MARK: - Detail menu for each category from menu

class MenuCategoryCollectionViewController: UICollectionViewController, Coordinating {
    
    var menu: Menu
    
    var coordinator: MainCoordinator?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Init
    
    init(menu: Menu, coordinator: MainCoordinator? = nil) {
        self.menu = menu
        self.coordinator = coordinator
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogo()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listens to notification from last page (when user returns from final pay page)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(popToRootVC),
                                               name: .backToHome,
                                               object: nil)
        
        // Sets color of navigation items to black
        navigationController?.navigationBar.tintColor = .black
        UIBarButtonItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                            for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        view.addSubview(titleLabel)
        titleLabel.text = menu.title
        
        collectionView.register(MenuCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: MenuCategoryCollectionViewCell.identifier)
        collectionView.collectionViewLayout = layoutCollection()
        
        setBackgroundImage()
        setConstraints()
    }
    
    // Sets background image to vc
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundImageCenterPart"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.opacity = 0.1
        
        collectionView.backgroundView = backgroundImageView
    }
    
    // Makes pop to Home vc
    @objc private func popToRootVC() {
        navigationController?.popToRootViewController(animated: false)
    }
    
}

//MARK: - Constraints

extension MenuCategoryCollectionViewController {
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
}

// MARK: - DataSource

extension MenuCategoryCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCategoryCollectionViewCell.identifier,
                                                      for: indexPath) as! MenuCategoryCollectionViewCell
        
        let menuItem = menu.menuItems[indexPath.row]
        
        cell.configure(menuItem: menuItem)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menuItem = menu.menuItems[indexPath.row]
        let menuTitle = menu.title
        
        let menuItemReviewVC = MenuItemReviewViewController(menuItem: menuItem,
                                                            menuTitle: menuTitle,
                                                            coordinator: coordinator)
        
        navigationController?.pushViewController(menuItemReviewVC, animated: true)
    }
    
}

// MARK: - Layout

extension MenuCategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    // Sets layout model to vc
    private func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 90
        
        return layout
    }
    
}
