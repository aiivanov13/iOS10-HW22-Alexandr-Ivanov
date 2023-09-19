import UIKit
import SnapKit

final class DetailView: UIViewController, UINavigationControllerDelegate {
    var presenter: DetailViewOutput?
    private var isTouched = false

    // MARK: - Outlets

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.tintColor = .systemGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .redraw
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.isUserInteractionEnabled = false
        return stack
    }()

    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(chooseImage))
        return gesture
    }()

    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()

    private lazy var nameField = TextFieldCell(image: UIImage(systemName: "person") ?? UIImage())
    private lazy var dateField = TextFieldCell(image: UIImage(systemName: "calendar") ?? UIImage(), isDate: true)
    private lazy var genderField = TextFieldCell(image: UIImage(systemName: "person.2.circle") ?? UIImage())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupData()
        setupNotifications()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        view.addTapGestureToHideKeyboard()
    }

    private func setupHierarchy() {
        imageView.addGestureRecognizer(tapGesture)

        view.addSubviews(
            imageView,
            stackView
        )

        stackView.addArrangedSubviews(
            nameField,
            dateField,
            genderField
        )
    }

    private func setupLayout() {
        editButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(editButton.snp.height).multipliedBy(2.2)
        }

        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.top.equalTo(view.snp_topMargin).offset(30)
            make.centerX.equalTo(view)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.height.equalTo(200)
            make.leading.trailing.equalTo(view).inset(15)
        }
    }

    private func setupData() {
        nameField.text = presenter?.loadUser().name ?? ""
        genderField.text = presenter?.loadUser().gender ?? ""
        dateField.text = presenter?.loadUser().birthDate ?? ""
        imageView.image = UIImage(data: presenter?.loadUser().imageData ?? Data())
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Action

    @objc private func editButtonTapped() {
        isTouched.toggle()
        stackView.isUserInteractionEnabled.toggle()
        imageView.isUserInteractionEnabled.toggle()

        if isTouched {
            editButton.setTitle("Save", for: .normal)
        } else {
            editButton.setTitle("Edit", for: .normal)
            presenter?.updateUser(
                newImageData: imageView.image?.pngData() ?? Data(),
                newName: nameField.text,
                newBirthDate: dateField.text,
                newGender: genderField.text
            )
        }
    }

    @objc private func chooseImage(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true)
    }

    @objc private func backButtonTapped() {
        presenter?.backButtonTapped()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 1.3
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension DetailView: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true)
    }
}

// MARK: - DetailViewInput

extension DetailView: DetailViewInput {

}
