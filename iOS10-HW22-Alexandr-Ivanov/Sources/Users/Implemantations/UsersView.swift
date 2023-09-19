import UIKit
import SnapKit

final class UsersView: UIViewController {
    var presenter: UsersViewOutput?

    // MARK: - Outlets

    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .null, style: .insetGrouped)
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var addTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 0)))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 0)))
        textField.rightViewMode = .always
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitle("Press", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchUsers()
        usersTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .white
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupHierarchy() {
        view.addSubviews(
            addTextField,
            addButton,
            usersTableView
        )
    }

    private func setupLayout() {
        addTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(16)
            make.top.equalTo(view.snp_topMargin)
            make.height.equalTo(50)
        }

        addButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(16)
            make.top.equalTo(addTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }

        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view)
        }
    }

    // MARK: - Action

    @objc private func addButtonTapped() {
        addTextField.resignFirstResponder()

        if !(addTextField.text?.isEmpty ?? true) {
            presenter?.createUser(name: addTextField.text ?? "", imageData: DefaultImageData.photo)
            presenter?.fetchUsers()
            usersTableView.reloadData()
            addTextField.text = nil
        } else {
            alertController(title: "Error", message: "Invalid name")
        }
    }
}

// MARK: - UITableViewDelegate

extension UsersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cellTapped(at: indexPath)
        addTextField.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _  in
            self?.presenter?.deleteUser(with: indexPath.row)
            self?.presenter?.fetchUsers()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: - UITableViewDataSource

extension UsersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.loadUsers().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { return UITableViewCell() }
        cell.configuration(name: presenter?.loadUsers()[indexPath.row].name ?? "")
        return cell
    }
}

// MARK: - UITextFieldDelegate

extension UsersView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UsersViewInput

extension UsersView: UsersViewInput {
    
}
