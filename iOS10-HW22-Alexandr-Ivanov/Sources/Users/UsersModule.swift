import UIKit

class UsersModule {
    func makeModule() -> UIViewController {
        let viewController = UsersView()
        let presenter = UsersPresenter(view: viewController)
        let router = UsersRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.router = router

        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
