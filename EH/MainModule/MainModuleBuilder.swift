import UIKit

protocol MainModuleBuilderProtocol {
    static func build() -> MainViewController
}

final class MainModuleBuilder: MainModuleBuilderProtocol {
    static func build() -> MainViewController {
        let model = MainModel()
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, model: model)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
