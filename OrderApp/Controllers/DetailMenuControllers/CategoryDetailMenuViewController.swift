//
//  SecondViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

// MARK: - Detail menu for each category from menu

class CategoryDetailMenuViewController: UICollectionViewController {

    var coordinator: MainCoordinator?
    
    var menu: Menu
    
    private let logoImageView = UIImageView()
    
    private let logoContainerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        //label.text = "Top Salers"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
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

        configureLogoImage()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }

   //MARK: - Configure CollectionView
    
    func configureVC() {
        view.addSubview(titleLabel)
        titleLabel.text = menu.title
        
        collectionView.register(DetailMenuCollectionViewCell.self, forCellWithReuseIdentifier: DetailMenuCollectionViewCell.identifier)
        collectionView.collectionViewLayout = layoutCollection()
    
        setBackgroundImage()
        setConstraints()
    }
    
    func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundImageSecondPart"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.opacity = 0.1

        collectionView.backgroundView = backgroundImageView
    }

    
    //MARK: - App Logo
    
    func configureLogoImage() {
        logoImageView.image = UIImage(named: "logoWelms")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = .systemGray6
        
        view.addSubview(logoContainerView)
        logoContainerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 7)
        logoContainerView.backgroundColor = .systemGray6
        logoContainerView.addSubview(logoImageView)
       
        setLogoImageConstraints()
    }

    
    //MARK: - Constraints
      
    func setLogoImageConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
         logoImageView.heightAnchor.constraint(equalToConstant: 60),
         logoImageView.widthAnchor.constraint(equalToConstant: 200),

         logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
         logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
      func setConstraints() {
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              titleLabel.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: 20),
              titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
             
              collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10),
              collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
              
          ])
      }

}

extension CategoryDetailMenuViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.menuItem.count
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMenuCollectionViewCell.identifier, for: indexPath) as! DetailMenuCollectionViewCell
        
        cell.configure(name: menu.menuItem[indexPath.row].imageName, title: menu.menuItem[indexPath.row].title)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailInfoVC = DetailInfoViewController(menuItem: menu.menuItem[indexPath.row], coordinator: coordinator)
        
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
  
}

extension CategoryDetailMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 50
        
        return layout
    }
    
}
