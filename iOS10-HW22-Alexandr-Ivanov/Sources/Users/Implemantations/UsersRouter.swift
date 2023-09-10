import UIKit

class UsersRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - UsersRouterInput

extension UsersRouter: UsersRouterInput {

}
