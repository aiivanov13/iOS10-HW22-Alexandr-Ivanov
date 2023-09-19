import UIKit
import SnapKit

final class TextFieldCell: UIView {

    // MARK: - Outlets

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var imageViewContainer: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        return textField
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.sizeToFit()
        return picker
    }()

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolBar.barTintColor = .white
        toolBar.backgroundColor = .white
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(tapDone))
        toolBar.setItems([flexible, barButton], animated: true)
        return toolBar
    }()

    var text: String {
        get {
            textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }

    // MARK: - Initializers

    init(image: UIImage, isDate: Bool? = false) {
        super.init(frame: .zero)
        imageView.image = image
        setupHierarchy(isDate: isDate ?? false)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy(isDate: Bool) {
        if isDate {
            textField.inputView = datePicker
            textField.inputAccessoryView = toolBar
        }

        imageViewContainer.addSubview(imageView)
        
        addSubviews(
            separator,
            imageViewContainer,
            textField
        )
    }

    private func setupLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(1)
        }

        imageViewContainer.snp.makeConstraints { make in
            make.leading.centerY.equalTo(self)
            make.height.width.equalTo(30)
        }

        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(imageViewContainer)
        }

        textField.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(self)
            make.leading.equalTo(imageViewContainer.snp.trailing).offset(15)
        }
    }

    // MARK: - Action

    @objc private func tapDone() {
        textField.text = datePicker.date.string
        textField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
