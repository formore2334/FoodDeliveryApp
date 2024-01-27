//
//  CheckoutListViewController.swift
//  OrderApp
//
//  Created by ForMore on 15/11/2023.
//

import UIKit


class CheckoutListViewController: UIViewController {
    
    var basket: Basket
    
    // Sets enum array which represents each tableView cell
    private let checkoutListItems: [CheckoutList] = [.name, .phone, .email, .address, .comment, .coupon]
    
    private let formContentBuilder = FormContentBuilder()
    
    private let customButton = CustomButton()
    
    // MARK: - Set variables
    
    private var tableView = UITableView()
    
    private var contentView = UIView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var totalSumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    // This label needs just for present static info for developers
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Note: If you enter correctly all information, click on comment field to continue, because i'm doing this table validation without Combine -_-"
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Init
    
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
        
        setCustomButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sets color of navigation items to black
        navigationController?.navigationBar.tintColor = .black
        UIBarButtonItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black],
                                    for: .normal)
    }
    
    //MARK: - Configurations
    
    // Sets logo to nav bar pannel
    private func configureLogo() {
         guard let navigationController = navigationController else { return }
         
         let logoView = LogoView()
         logoView.setupNavigationBarLogo(in: navigationController, with: navigationItem)
     }
    
    private func configureVC() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        configureTableView()
        configureTotalSum()
        
        setScrollViewConstraints()
    }
    
    private func configureTableView() {
        
        // Create and configure the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.register(CheckoutListTableViewCell.self,
                           forCellReuseIdentifier: CheckoutListTableViewCell.identifier)
        
        contentView.addSubview(tableView)
        
        setTableViewConstraints()
    }
    
    // Config final label with total sum for pay
    private func configureTotalSum() {
        contentView.addSubview(totalTitleLabel)
        contentView.addSubview(totalSumLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(noteLabel)
        
        discountLabel.text = "\(basket.totalSum)$"
        
        setTotalInfoConstraints()
    }
   
}

// MARK: - Delegate

extension CheckoutListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - DataSource

extension CheckoutListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutListTableViewCell.identifier,
                                                 for: indexPath) as! CheckoutListTableViewCell
        
        let checkoutListItem = checkoutListItems[indexPath.row]
        cell.configure(with: checkoutListItem)
        
        // Closure from cell which fills user model with the necessary data
        cell.didEnterText = { [weak self] text in
            
            guard let self = self else { return }
            
            // Validate all text fields
            switch checkoutListItem {
                
                // Validate name text field
                // Returns error for error label in this vc
            case .name:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .name) {
                    cell.errorLabel?.text = errorText as? String
                }
                
                // Validate phone text field
                // Returns error for error label in this vc
            case .phone:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .phone) {
                    cell.errorLabel?.text = errorText as? String
                }
                
                // Validate email text field
                // Returns error for error label in this vc
            case .email:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .email) {
                    cell.errorLabel?.text = errorText as? String
                }
                
                // Validate address text field
                // Returns error for error label in this vc
            case .address:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .address) {
                    cell.errorLabel?.text = errorText as? String
                }
                
                // Validate comment text field
            case .comment:
                if let (_, _) = self.formContentBuilder.updateUserInfo(text: text, for: .comment) {
                    //
                }
                
                // Validate coupon text field
                // Returns final price and old price
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

//MARK: - Custom button action

private extension CheckoutListViewController {
    
    // Config custom button with pay action
    func setCustomButton() {
        view.addSubview(customButton)
        customButton.setTitle("Pay", for: .normal)
        customButton.backgroundColor = UIColor(named: "lightBlue")
        customButton.pinPayBtn(to: view)
        
        addActionToCustomButton()
    }
    
    // Adds action
    func addActionToCustomButton() {
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
    }
    
    @objc func customButtonTapped() {
        
        // Checks for valid data to continue
        if formContentBuilder.isValid {
            
            customButton.press()

            let userInfo = formContentBuilder.userInfo
            let payVC = PayViewController(userInfo: userInfo, basket: basket)
            
            // Makes style for nav back button
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationController?.pushViewController(payVC, animated: true)
        } else {
            customButton.shake()
        }
        
    }
    
}

// MARK: - Constraints

private extension CheckoutListViewController {
    
    // Scroll view & content view constraints
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    //Table view constraints
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 360),
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    //Total info constraints
    func setTotalInfoConstraints() {
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalSumLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            totalTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            totalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            discountLabel.heightAnchor.constraint(equalToConstant: 25),
            discountLabel.centerYAnchor.constraint(equalTo: totalTitleLabel.centerYAnchor),
            discountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            totalSumLabel.heightAnchor.constraint(equalToConstant: 25),
            totalSumLabel.leadingAnchor.constraint(equalTo: discountLabel.trailingAnchor, constant: -16),
            totalSumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            totalSumLabel.bottomAnchor.constraint(equalTo: discountLabel.topAnchor),
            
            noteLabel.topAnchor.constraint(equalTo: totalTitleLabel.bottomAnchor, constant: 10),
            noteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
    
}
