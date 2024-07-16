import UIKit

protocol DeleteHabitPresenterProtocol: AnyObject {
    init(view: DeleteHabitViewControllerProtocol, model: MainModel)
}

class DeleteHabitPresenter: DeleteHabitPresenterProtocol {
    var view: DeleteHabitViewControllerProtocol
    var model: MainModel
    
    required init(view: DeleteHabitViewControllerProtocol, model: MainModel) {
        self.view = view
        self.model = model
    }
    
}
