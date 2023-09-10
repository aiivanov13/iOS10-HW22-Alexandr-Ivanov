import Foundation

class UsersPresenter {
    weak var view: UsersViewInput?
    var router: UsersRouterInput?

    init(view: UsersViewInput) {
        self.view = view
    }
}

// MARK: - UsersViewOutput

extension UsersPresenter: UsersViewOutput {

}
