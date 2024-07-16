import UIKit

protocol DeleteHabitViewControllerProtocol: AnyObject {
    
}
class DeleteHabitViewController: UIViewController, DeleteHabitViewControllerProtocol {
    
    var presenter: DeleteHabitPresenterProtocol?
    private let shapeLayer = CAShapeLayer()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "easyhabits")
        return imageView
    }()
    
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var supportLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Не расстраивайтесь!\nВсегда можно начать сначала, главное сделать правильные выводы."
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = .systemFont(ofSize: 15, weight: .bold)
        return descLabel
    }()
    
    private lazy var adviceLabel: UILabel = {
        let name = UILabel()
        name.text = "Расскажите себе, почему в этот раз у вас не получилось и дайте себе совет в \"завтра\"!"
        name.textColor = .darkGray
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: 14, weight: .bold)
        return name
    }()
    
    private lazy var adviceTextView: UITextView = {
        let nameTF = UITextView()
        nameTF.keyboardAppearance = .light
        nameTF.keyboardType = .default
        nameTF.layer.cornerRadius = 10.0
        nameTF.layer.masksToBounds = true
        nameTF.layer.borderWidth = 0.1
        nameTF.font = .systemFont(ofSize: 16)
        nameTF.backgroundColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        return nameTF
    }()
    
    private lazy var adviceStackView: UIStackView = {
        let nameSV = UIStackView(arrangedSubviews: [adviceLabel,adviceTextView])
        nameSV.axis = .vertical
        nameSV.spacing = 15
        nameSV.alignment = .fill
        nameSV.translatesAutoresizingMaskIntoConstraints = false
        return nameSV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createProgressShape()
        addSubviews()
        addConstraints()
    }

    @objc private func popViewController() {
        navigationController?.popViewController(animated: false)
    }
    
}

private extension DeleteHabitViewController {
    func addSubviews() {
        navigationItem.titleView = self.titleImageView
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(popViewController))
        view.addSubview(supportLabel)
        view.addSubview(adviceStackView)
        view.addSubview(deleteHabitButton)
    }
    
    func addConstraints() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            titleImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            
            supportLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            supportLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            supportLabel.widthAnchor.constraint(equalToConstant: 240),
            
            adviceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: adviceStackView.trailingAnchor, constant: 25),
            adviceStackView.topAnchor.constraint(equalTo: supportLabel.bottomAnchor, constant: 20),
            adviceTextView.heightAnchor.constraint(equalToConstant: 130),
            
            view.centerXAnchor.constraint(equalTo: deleteHabitButton.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: deleteHabitButton.bottomAnchor, constant: 20),
            deleteHabitButton.heightAnchor.constraint(equalToConstant: 55),
            deleteHabitButton.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func createProgressShape() {
        let centerY = UIScreen.main.bounds.height / 3.5
        let centerX = UIScreen.main.bounds.width / 2
        let trackLayer = CAShapeLayer ()
        let circularPath = UIBezierPath (arcCenter: CGPoint(x: centerX, y: centerY), radius: 70,
                                         startAngle: CGFloat.pi / 0.67, endAngle: CGFloat.pi, clockwise:
        true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.red.cgColor
        trackLayer.lineWidth = 65
        trackLayer.fillColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        view.layer.addSublayer (trackLayer)
        
        let shapeLayerPath = UIBezierPath (arcCenter: CGPoint(x: centerX, y: centerY), radius: 70,
                                         startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = shapeLayerPath.cgPath
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 30
        shapeLayer.strokeEnd = 1
        shapeLayer.fillColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        view.layer.addSublayer(shapeLayer)
    }
}
