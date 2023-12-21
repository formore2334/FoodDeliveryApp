//
//  ErrorScreenViewController.swift
//  OrderApp
//
//  Created by ForMore on 18/12/2023.
//

import UIKit
import FLAnimatedImage

class ErrorScreenViewController: UIViewController {
    
    // Set navigation controller to appear alert
    let customNavigationController = UINavigationController()
    
    let networkManager = NetworkManager()
    
    private let loadingView = LoadingView()

    private let container = UIView()
    
    // Set GIF container
    private lazy var backgroundGIFImageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoWithHelmet")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "serviceLogo")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var loadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var loadinglabel: UILabel = {
        let label = UILabel()
        label.text = "Wait couple seconds..."
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "We are already correcting all the errors. The app will be available soon."
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var simulateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "Just a simulated scenario. Don't do anything. Everything will work now."
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("Error VC init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleErrorChange(notification:)),
                                               name: NSNotification.Name("ErrorValueChangedNotification"),
                                               object: nil)
        
        
        setCustomViewController()
        configureVC()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        loadinglabel.stopBlinkingAnimation()
        print("Error VC deinit")
    }
    
    // MARK: - Configurations
    
    private func configureVC() {
        view.addSubview(backgroundGIFImageView)
        view.sendSubviewToBack(backgroundGIFImageView)
        
        backgroundGIFImageView.pinToBounds(to: view)
        
        view.addSubview(container)
        view.addSubview(errorLabel)
        view.addSubview(simulateDescriptionLabel)
        
        container.addSubview(logoImageView)
        container.addSubview(serviceImageView)
        
        configureLoadingStackView()
        getImage()
        setConstraints()
    }
    
    private func configureLoadingStackView() {
        view.addSubview(loadingStackView)
        
        loadingStackView.addArrangedSubview(loadingView)
        loadingStackView.addArrangedSubview(loadinglabel)
        
        setStackViewConstraints()
    }
  
    private func setCustomViewController() {
        addChild(customNavigationController)
        view.addSubview(customNavigationController.view)
        customNavigationController.didMove(toParent: self)
        
        customNavigationController.isNavigationBarHidden = true
    }
    
    // Fetch GIF image
    private func getImage() {
        guard let urlString = URL(string: "https://cdn.dribbble.com/users/707433/screenshots/6720160/gears2.gif") else { return }
        
        loadingView.startAnimating()
        loadinglabel.startBlinkingAnimation()
        errorLabel.isHidden = true
        
        networkManager.fetchData(url: urlString) { [weak self] data, error in
            DispatchQueue.main.async {
                self?.backgroundGIFImageView.animatedImage = FLAnimatedImage(gifData: data)
                
                self?.loadingView.stopAnimating()
                self?.loadinglabel.stopBlinkingAnimation()
                self?.loadinglabel.isHidden = true
                self?.errorLabel.isHidden = false
                self?.activateAdditionalDescription()
            }
        }
        
    }
    
    // Only demonstraition info labels
    private func activateAdditionalDescription() {
        setSimulateDescriptionConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.simulateDescriptionLabel.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.loadinglabel.isHidden = false
            self?.loadinglabel.startBlinkingAnimation()
        }
        
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        customNavigationController.present(alert, animated: true)
    }
    
    // Handle notification
    @objc private func handleErrorChange(notification: Notification) {
        if let error = notification.object as? Error {
            showAlert(message: error.localizedDescription)
        }
    }
    
    //MARK: - Set constraints
    
    private func setConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        serviceImageView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            container.widthAnchor.constraint(equalToConstant: 300),
            container.heightAnchor.constraint(equalToConstant: 150),
            
            logoImageView.topAnchor.constraint(equalTo: container.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            logoImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6),
            
            serviceImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -20),
            serviceImageView.leadingAnchor.constraint(equalTo: logoImageView.centerXAnchor, constant: -15),
            serviceImageView.widthAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 0.4),
            serviceImageView.heightAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 0.4),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            errorLabel.widthAnchor.constraint(equalToConstant: 300),
            errorLabel.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setStackViewConstraints() {
        loadingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            loadingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loadingStackView.widthAnchor.constraint(equalToConstant: 120),
            loadingStackView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
    }
    
    private func setSimulateDescriptionConstraints() {
        simulateDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            simulateDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simulateDescriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            simulateDescriptionLabel.widthAnchor.constraint(equalToConstant: 300),
            simulateDescriptionLabel.heightAnchor.constraint(equalToConstant: 150),
        ])
        
    }

}
