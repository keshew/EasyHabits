import Foundation

protocol DeleteHabitModuleBuilderProtocol {
    static func build() -> DeleteHabitViewController
}

final class DeleteHabitModuleBuilder: DeleteHabitModuleBuilderProtocol {
    static func build() -> DeleteHabitViewController {
        let model = MainModel()
        let viewController = DeleteHabitViewController()
        let presenter = DeleteHabitPresenter(view: viewController, model: model)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
