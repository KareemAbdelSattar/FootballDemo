import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}


final class AppCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let teamVC = setupTeamViewController()
        navigationController.pushViewController(teamVC, animated: true)
    }
}

private extension AppCoordinator {
    func setupTeamViewController() -> UIViewController {
        let viewModel = TeamViewModel(teamFireStore: DefaultTeamFireStore())
        let teamVC = TeamViewController(viewModel: viewModel)
        return teamVC
    }
}
