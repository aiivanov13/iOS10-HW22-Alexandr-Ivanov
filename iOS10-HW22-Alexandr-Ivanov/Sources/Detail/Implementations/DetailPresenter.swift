import Foundation

final class DetailPresenter {
    private weak var view: DetailViewInput?
    private var router: DetailRouterInput?
    private var dataManager: CoreDataManagerUpdate?

    private var user: User

    // MARK: - Initializers

    init(user: User, view: DetailViewInput, dataManager: CoreDataManagerUpdate, router: DetailRouterInput) {
        self.user = user
        self.view = view
        self.dataManager = dataManager
        self.router = router
    }
}

// MARK: - DetailViewOutput

extension DetailPresenter: DetailViewOutput {
    func updateUser(newImageData: Data, newName: String, newBirthDate: String, newGender: String) {
        dataManager?.updateUser(user, newImageData: newImageData, newName: newName, newBirthDate: newBirthDate, newGender: newGender)
    }

    func loadUser() -> User {
        user
    }

    func backButtonTapped() {
        router?.popViewController()
    }
}
