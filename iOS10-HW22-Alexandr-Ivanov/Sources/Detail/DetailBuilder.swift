import UIKit

final class DetailBuilder {
    func makeModule(with user: User) -> UIViewController {
        let viewController = DetailView()
        let router = DetailRouter(viewController: viewController)
        let coreDataManager = CoreDataManager()
        let presenter = DetailPresenter(user: user, view: viewController, dataManager: coreDataManager, router: router)
        viewController.presenter = presenter

        return viewController
    }
}
