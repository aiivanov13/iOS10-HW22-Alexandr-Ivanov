import Foundation

extension Date {
    var string: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        return dateformatter.string(from: self)
    }
}
