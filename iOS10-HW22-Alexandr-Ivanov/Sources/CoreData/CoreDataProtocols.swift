import Foundation

protocol CoreDataManagerInput: AnyObject {
    func createUser(imageData: Data?, name: String, birthDate: String?, gender: String?)
    func fetchUsers(completion: @escaping ([User]) -> Void)
    func deleteUser(_ user: User)
}

protocol CoreDataManagerUpdate: AnyObject {
    func updateUser(_ user: User, newImageData: Data?, newName: String, newBirthDate: String, newGender: String?)
}
