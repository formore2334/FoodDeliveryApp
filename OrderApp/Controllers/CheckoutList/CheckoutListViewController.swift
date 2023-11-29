//
//  CheckoutListViewController.swift
//  OrderApp
//
//  Created by ForMore on 15/11/2023.
//

import UIKit


class CheckoutListViewController: UIViewController {
    
    var basket: Basket
    
    private let formContentBuilder = FormContentBuilder()
    
    private var tableView = UITableView()
    
    private let customButton = CustomButton()
    
    private let checkoutListItems: [CheckoutList] = [.name, .phone, .email, .address, .comment, .coupon]
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let totalSumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    
    init(basket: Basket) {
        self.basket = basket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogo()
        configureVC()
        configureTotalInfo()
        setCustomButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    //MARK: - Configurations
    
    private func configureLogo() {
         guard let navigationController = navigationController else { return }
         
         let logoView = LogoView()
         logoView.setupNavigationBarLogo(in: navigationController, with: navigationItem)
     }
    
    private func configureVC() {
        // Create and configure the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.register(CheckoutListCell.self, forCellReuseIdentifier: CheckoutListCell.identifier)
        view.addSubview(tableView)
        
        setConstraints()
    }
    
    private func configureTotalInfo() {
        view.addSubview(totalTitleLabel)
        view.addSubview(totalSumLabel)
        view.addSubview(discountLabel)
        
        discountLabel.text = "\(basket.totalSum)$"
        
        setTotalInfoConstraints()
    }
    
    //MARK: - Basket Button translation
    
    private func setCustomButton() {
        view.addSubview(customButton)
        customButton.setTitle("Pay", for: .normal)
        customButton.backgroundColor = UIColor.init(red: 51/255, green: 153/255, blue: 255/255, alpha: 0.9)
        customButton.pinPayBtn(to: view)
        addActionToCustomButton()
    }
    
    private func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc private func customButtonTapped() {
        if formContentBuilder.isValid {
            customButton.press()
            
            let payVC = PayViewController()
            navigationController?.pushViewController(payVC, animated: true)
        } else {
            customButton.shake()
        }
    }
    
    // MARK: - Constraints
    
    
    //Table view constraints
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 360),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    //Total info constraints
    func setTotalInfoConstraints() {
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalSumLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            totalTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            totalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            discountLabel.heightAnchor.constraint(equalToConstant: 25),
            discountLabel.centerYAnchor.constraint(equalTo: totalTitleLabel.centerYAnchor),
            discountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            totalSumLabel.heightAnchor.constraint(equalToConstant: 25),
            totalSumLabel.leadingAnchor.constraint(equalTo: discountLabel.trailingAnchor, constant: -16),
            totalSumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            totalSumLabel.bottomAnchor.constraint(equalTo: discountLabel.topAnchor)
        ])
    }
   
}

extension CheckoutListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CheckoutListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutListCell.identifier, for: indexPath) as! CheckoutListCell
        
        let checkoutListItem = checkoutListItems[indexPath.row]
        cell.configure(with: checkoutListItem)
        cell.didEnterText = { [weak self] text in
            
            guard let self = self else { return }
            
            // Validate all text fields
            switch checkoutListItem {
                
            case .name:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .name) {
                    cell.errorLabel.text = errorText as? String
                }
                
            case .phone:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .phone) {
                    cell.errorLabel.text = errorText as? String
                }
                
            case .email:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .email) {
                    cell.errorLabel.text = errorText as? String
                }
                
            case .address:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .address) {
                    cell.errorLabel.text = errorText as? String
                }
                
            case .comment:
                if let (_, _) = self.formContentBuilder.updateUserInfo(text: text, for: .comment) {
                    //
                }
                
            case .coupon:
                if let (calculatedDiscount, crossedTotalSum) = self.formContentBuilder.updateUserInfo(text: text, for: .coupon, with: self.basket) {
                    self.discountLabel.text = calculatedDiscount
                    self.totalSumLabel.attributedText = crossedTotalSum as? NSAttributedString
                } else {
                    self.discountLabel.text = "\(self.basket.totalSum)"
                    self.totalSumLabel.text = ""
                }
                
            }
           
        }
        
        return cell
    }
    
}
