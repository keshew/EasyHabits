import UIKit

protocol CreateHabitPresenterProtocol: AnyObject {
    init(view: CreateHabitViewControllerProtocol, model: MainModel)
    
}

class CreateHabitPresenter: CreateHabitPresenterProtocol {
    var view: CreateHabitViewControllerProtocol
    var model: MainModel
    
    required init(view: CreateHabitViewControllerProtocol, model: MainModel) {
        self.view = view
        self.model = model
    }
    
}
