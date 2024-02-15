//
//  CheckoutListViewController.swift
//  OrderApp
//
//  Created by ForMore on 15/11/2023.
//

import UIKit


final class CheckoutListViewController: UIViewController {
    
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Note: Make sure you entered all information correctly.\nThis determines how quickly the order will be delivered."
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
        setGestureRecognizer()
        
        setCustomButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .white
        
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
         logoView.configureIntoNavBar(in: navigationController, with: navigationItem)
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(oldPriceLabel)
        contentView.addSubview(newPriceLabel)
        contentView.addSubview(noteLabel)
        
        newPriceLabel.text = "\(basket.totalSum)$"
        
        setTotalInfoConstraints()
    }
    
    // Setup gesture which cancels touches in view
    private func setGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // Stop editing & hide keyboard
    @objc func hideKeyboard() {
        view.endEditing(true)
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
                    cell.configureErrorLabel(errorText as? String ?? "")
                }
                
                // Validate phone text field
                // Returns error for error label in this vc
            case .phone:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .phone) {
                    cell.configureErrorLabel(errorText as? String ?? "")
                }
                
                // Validate email text field
                // Returns error for error label in this vc
            case .email:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .email) {
                    cell.configureErrorLabel(errorText as? String ?? "")
                }
                
                // Validate address text field
                // Returns error for error label in this vc
            case .address:
                if let (_, errorText) = self.formContentBuilder.updateUserInfo(text: text, for: .address) {
                    cell.configureErrorLabel(errorText as? String ?? "")
                }
                
                // Validate comment text field
            case .comment:
                if let (_, _) = self.formContentBuilder.updateUserInfo(text: text, for: .comment) {
                    //
                }
                
                // Validate coupon text field
                // Returns final price and old price
            case .coupon:
                if let (newTotalSum, oldTotalSum) = self.formContentBuilder.updateUserInfo(text: text,
                                                                                           for: .coupon,
                                                                                           with: self.basket) {
                    self.newPriceLabel.text = newTotalSum
                    self.oldPriceLabel.attributedText = oldTotalSum as? NSAttributedString
                } else {
                    self.newPriceLabel.text = "\(self.basket.totalSum)$"
                    self.oldPriceLabel.text = ""
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
        customButton.pinWithSmallFrame(to: view)
        
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        oldPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        newPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            newPriceLabel.heightAnchor.constraint(equalToConstant: 25),
            newPriceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            newPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            oldPriceLabel.heightAnchor.constraint(equalToConstant: 25),
            oldPriceLabel.leadingAnchor.constraint(equalTo: newPriceLabel.trailingAnchor, constant: -16),
            oldPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            oldPriceLabel.bottomAnchor.constraint(equalTo: newPriceLabel.topAnchor),
            
            noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            noteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
    
}
