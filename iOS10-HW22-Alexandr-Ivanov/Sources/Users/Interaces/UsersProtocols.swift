import Foundation

// Presenter -> View
protocol UsersViewInput: AnyObject {

}

// View -> Presenter
protocol UsersViewOutput: AnyObject {
    func loadUsers() -> [User]
    func fetchUsers()
    func createUser(name: String, imageData: Data)
    func deleteUser(with index: Int)
    func cellTapped(at indexPath: IndexPath)
}

// Presenter -> Router
protocol UsersRouterInput: AnyObject {
    func pushDetail(with user: User)
}
