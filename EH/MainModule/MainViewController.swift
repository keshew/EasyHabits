import UIKit
import SnapKit

protocol MainViewControllerProtocol: AnyObject {
    
}

class MainViewController: UIViewController, MainViewControllerProtocol {
    
    var presenter: MainPresenterProtocol?
    let sectionNames = ["В процессе", "Успешно", "Провал"]
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "easyhabits")
        return imageView
    }()
    
    private lazy var addHabitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createNewHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 130
        view.separatorStyle = .none
        view.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
}


private extension MainViewController {
    
    func addSubviews() {
        navigationItem.titleView = self.titleImageView
        view.addSubview(tableView)
        view.addSubview(addHabitButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            addHabitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            addHabitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: addHabitButton.bottomAnchor, constant: 20),
            addHabitButton.widthAnchor.constraint(equalToConstant: 50),
            addHabitButton.heightAnchor.constraint(equalToConstant: 50)
          
        ])
    }
    
    func createCustomHeader(section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0,
                                                        y: 0,
                                                        width: tableView.frame.width,
                                                        height: 50))
        lazy var label: UILabel = {
            let label = UILabel()
            label.frame = CGRect.init(x: 15,
                                      y: 5,
                                      width: headerView.frame.width-10,
                                      height: headerView.frame.height-30)
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        headerView.addSubview(label)
       
        switch section {
        case 0:
            label.text = sectionNames[section]
            label.textColor = .black
            return headerView
            
        case 1:
            label.text = sectionNames[section]
            label.textColor = #colorLiteral(red: 0.180293411, green: 0.7328081727, blue: 0.09719144553, alpha: 1)
            return headerView
            
        case 2:
            label.text = sectionNames[section]
            label.textColor = #colorLiteral(red: 0.8650140762, green: 0.08271122724, blue: 0.08951089531, alpha: 1)
            return headerView
            
        default:
            return headerView
        }
    }
    
    @objc func createNewHabit() {
        let createNewHabitController = CreateHabitModuleBuilder.build()
        navigationController?.pushViewController(createNewHabitController, animated: false)
    }
}



extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
       cell.delegate = self
       return cell
   }
}

extension MainViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      createCustomHeader(section: section)
   }
}

extension MainViewController: MyTableViewCellDelegate {
    func presentAlert(from cell: MainTableViewCell) {
        let alertController = UIAlertController(title: "Удалить", message: "Вы уверены, что хотите удалить привычку?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { action in
            self.navigationController?.pushViewController(DeleteHabitModuleBuilder.build(), animated: false)
        }
        let cancelActon = UIAlertAction(title: "Отмена", style: .default)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelActon)
        present(alertController, animated: true, completion: nil)
    }
}
