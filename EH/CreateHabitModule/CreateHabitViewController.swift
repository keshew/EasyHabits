import UIKit
import SnapKit

protocol CreateHabitViewControllerProtocol: AnyObject {
    
}

class CreateHabitViewController: UIViewController, CreateHabitViewControllerProtocol {
    var presenter: CreateHabitPresenterProtocol?
    private let shapeLayer = CAShapeLayer()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "easyhabits")
        return imageView
    }()
    
    private lazy var createNewHabitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createNewHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameOfTargetLabel: UILabel = {
        let name = UILabel()
        name.text = "Придумайте краткое название"
        name.textColor = .darkGray
        name.font = .systemFont(ofSize: 14, weight: .bold)
        return name
    }()
    
    private lazy var targetTextField: UITextField = {
        let nameTF = UITextField()
        nameTF.borderStyle = .roundedRect
        nameTF.keyboardAppearance = .light
        nameTF.keyboardType = .default
        nameTF.font = .systemFont(ofSize: 16)
        nameTF.backgroundColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        return nameTF
    }()
    
    private lazy var targetStackView: UIStackView = {
        let nameSV = UIStackView(arrangedSubviews: [nameOfTargetLabel,targetTextField])
        nameSV.axis = .vertical
        nameSV.spacing = 10
        nameSV.alignment = .fill
        nameSV.translatesAutoresizingMaskIntoConstraints = false
        return nameSV
    }()
    
    private lazy var numberOfDaysLabel: UILabel = {
        let name = UILabel()
        name.text = "Напишите число дней или раз, которое планируете для закрепления привычки"
        name.textColor = .darkGray
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: 14, weight: .bold)
        return name
    }()
    
    private lazy var numberOfDaysTextField: UITextField = {
        let nameTF = UITextField()
        nameTF.borderStyle = .roundedRect
        nameTF.keyboardAppearance = .light
        nameTF.keyboardType = .default
        nameTF.font = .systemFont(ofSize: 16)
        nameTF.backgroundColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        return nameTF
    }()
    
    private lazy var numberOfDaysStackView: UIStackView = {
        let nameSV = UIStackView(arrangedSubviews: [numberOfDaysLabel,numberOfDaysTextField])
        nameSV.axis = .vertical
        nameSV.spacing = 10
        nameSV.alignment = .leading
        nameSV.translatesAutoresizingMaskIntoConstraints = false
        return nameSV
    }()
    
    private lazy var reasonToStartLabel: UILabel = {
        let name = UILabel()
        name.text = "Напишите себе напоминание, почему вы начали этот и зачем вам это?"
        name.textColor = .darkGray
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: 14, weight: .bold)
        return name
    }()
    
    private lazy var reasonToStartTextView: UITextView = {
        let nameTF = UITextView()
        nameTF.keyboardAppearance = .light
        nameTF.layer.cornerRadius = 10.0
        nameTF.layer.masksToBounds = true
        nameTF.layer.borderWidth = 0.1
        nameTF.keyboardType = .default
        nameTF.font = .systemFont(ofSize: 16)
        nameTF.backgroundColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        return nameTF
    }()
    
    private lazy var reasonToStartStackView: UIStackView = {
        let nameSV = UIStackView(arrangedSubviews: [reasonToStartLabel,reasonToStartTextView])
        nameSV.axis = .vertical
        nameSV.spacing = 10
        nameSV.alignment = .fill
        nameSV.translatesAutoresizingMaskIntoConstraints = false
        return nameSV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        createProgressShape()
        addConstraints()
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func createNewHabit() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
}

private extension CreateHabitViewController {
    func addSubviews() {
        navigationItem.titleView = self.titleImageView
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(popViewController))
        view.addSubview(targetStackView)
        view.addSubview(numberOfDaysStackView)
        view.addSubview(reasonToStartStackView)
        view.addSubview(createNewHabitButton)
    }
    
    func addConstraints() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            titleImageView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            
            targetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: targetStackView.trailingAnchor, constant: 25),
            targetStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            numberOfDaysStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: numberOfDaysStackView.trailingAnchor, constant: 25),
            numberOfDaysStackView.topAnchor.constraint(equalTo: targetStackView.bottomAnchor, constant: 30),
            
            reasonToStartStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: reasonToStartStackView.trailingAnchor, constant: 25),
            reasonToStartStackView.topAnchor.constraint(equalTo: numberOfDaysStackView.bottomAnchor, constant: 30),
            reasonToStartTextView.heightAnchor.constraint(equalToConstant: 75),
            
            view.centerXAnchor.constraint(equalTo: createNewHabitButton.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: createNewHabitButton.bottomAnchor, constant: 20),
            createNewHabitButton.heightAnchor.constraint(equalToConstant: 50),
            createNewHabitButton.widthAnchor.constraint(equalToConstant: 50)
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
        trackLayer.strokeColor = UIColor.lightGray.cgColor
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
