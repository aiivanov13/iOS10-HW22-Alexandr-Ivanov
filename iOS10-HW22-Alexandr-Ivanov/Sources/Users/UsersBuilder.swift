import UIKit

final class UsersBuilder {
    func makeModule() -> UIViewController {
        let viewController = UsersView()
        let router = UsersRouter(viewController: viewController)
        let coreDataManager = CoreDataManager()
        let presenter = UsersPresenter(view: viewController, dataManager: coreDataManager, router: router)
        viewController.presenter = presenter

        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
