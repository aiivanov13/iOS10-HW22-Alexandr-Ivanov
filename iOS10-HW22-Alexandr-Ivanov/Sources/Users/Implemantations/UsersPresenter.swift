import Foundation

final class UsersPresenter {
    private weak var view: UsersViewInput?
    private var router: UsersRouterInput?
    private var dataManager: CoreDataManagerInput?

    private var users: [User] = []

    // MARK: - Initializers

    init(view: UsersViewInput, dataManager: CoreDataManagerInput, router: UsersRouterInput) {
        self.view = view
        self.dataManager = dataManager
        self.router = router
    }
}

// MARK: - UsersViewOutput

extension UsersPresenter: UsersViewOutput {
    func cellTapped(at indexPath: IndexPath) {
        router?.pushDetail(with: users[indexPath.row])
    }

    func deleteUser(with index: Int) {
        dataManager?.deleteUser(users[index])
    }
    
    func createUser(name: String, imageData: Data) {
        dataManager?.createUser(imageData: imageData, name: name, birthDate: nil, gender: nil)
    }

    func loadUsers() -> [User] {
        self.users
    }

    func fetchUsers() {
        dataManager?.fetchUsers(completion: { users in
            self.users = users
        })
    }
}
