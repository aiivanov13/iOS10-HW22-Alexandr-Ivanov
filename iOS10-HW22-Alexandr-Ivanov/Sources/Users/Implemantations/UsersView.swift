import UIKit
import SnapKit

class UsersView: UIViewController {
    var presenter: UsersViewOutput?

    // MARK: - Outlets

    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 0)))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 0)))
        textField.rightViewMode = .always
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        return textField
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitle("Press", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupHierarchy() {
        view.addSubviews(
            searchTextField,
            searchButton,
            usersTableView
        )
    }

    private func setupLayout() {
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(16)
            make.top.equalTo(view.snp_topMargin)
            make.height.equalTo(50)
        }

        searchButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(16)
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }

        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
}

// MARK: - UITableViewDelegate

extension UsersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: - UITableViewDataSource

extension UsersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension UsersView: UsersViewInput {
    
}
