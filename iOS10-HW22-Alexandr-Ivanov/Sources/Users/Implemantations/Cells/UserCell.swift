import UIKit
import SnapKit

final class UserCell: UITableViewCell {
    static let identifier = "UserCell"

    // MARK: - Outlets

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(nameLabel)
        accessoryType = .disclosureIndicator
    }

    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(self)
        }
    }

    // MARK: - Configuration

    func configuration(name: String) {
        nameLabel.text = name
    }
}
