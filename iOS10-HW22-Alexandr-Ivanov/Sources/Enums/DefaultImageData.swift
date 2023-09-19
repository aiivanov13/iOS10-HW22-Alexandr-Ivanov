import UIKit

enum DefaultImageData {
    static let photo = UIImage(named: "defaultImage")?.pngData() ?? Data()
}
