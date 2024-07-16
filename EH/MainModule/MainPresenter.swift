import UIKit

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewControllerProtocol, model: MainModel)
    
}

class MainPresenter: MainPresenterProtocol {
    var view: MainViewControllerProtocol
    var model: MainModel
    
    required init(view: MainViewControllerProtocol, model: MainModel) {
        self.view = view
        self.model = model
    }
    
}
