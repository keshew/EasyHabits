import Foundation

protocol CreateHabitModuleBuilderProtocol {
    static func build() -> CreateHabitViewController
}

final class CreateHabitModuleBuilder: CreateHabitModuleBuilderProtocol {
    static func build() -> CreateHabitViewController {
        let model = MainModel()
        let viewController = CreateHabitViewController()
        let presenter = CreateHabitPresenter(view: viewController, model: model)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
