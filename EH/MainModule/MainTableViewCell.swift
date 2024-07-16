import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func presentAlert(from cell: MainTableViewCell)
}

class MainTableViewCell: UITableViewCell {

    
    static var identifier: String {
        String(describing: self)
    }
    
    private let shapeLayer = CAShapeLayer()
    weak var delegate: MyTableViewCellDelegate?
    
    private lazy var timesCountLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var increaseDayCountButton: UIButton = {
        let button = UIButton(type: .system)
        //настройку можно зашить в кастомный класс кнопки если реально будет в этом необходимость
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.1
        button.layer.zPosition = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var viewForShapeLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.addSublayer(shapeLayer)
        return view
    }()
    
    private lazy var reasonToStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Я решил начать потому что я недоволен своей текущей формой, постоянно чувствую усталось и считаю, что это поможет мне стать менее ленивым!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    private lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        label.text = "100 отжиманий в день"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var deleteHabitButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "cancel"), for: .normal)
        btn.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        btn.addTarget(self, action: #selector(presentAlertAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var targetAndDeleteBtnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [targetLabel, deleteHabitButton])
        stackView.spacing = 30
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var targetAndReasonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [targetAndDeleteBtnStackView, reasonToStartLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [viewForShapeLayer, targetAndReasonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = #colorLiteral(red: 0.9540931582, green: 0.9972276092, blue: 0.922354877, alpha: 1)
        stackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 3.0, leading: 3.0, bottom: 3.0, trailing: 3.0)
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstsains()
        createProgressBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
}
 
private extension MainTableViewCell {
    
    func addSubviews() {
        contentView.addSubview(mainStackView)
        contentView.addSubview(increaseDayCountButton)
        viewForShapeLayer.addSubview(timesCountLabel)
    }
    
    func setupConstsains() {
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: margin.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            margin.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            margin.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            
            timesCountLabel.centerXAnchor.constraint(equalTo: viewForShapeLayer.centerXAnchor),
            timesCountLabel.centerYAnchor.constraint(equalTo: viewForShapeLayer.centerYAnchor),
            
            increaseDayCountButton.centerXAnchor.constraint(equalTo: viewForShapeLayer.centerXAnchor),
            increaseDayCountButton.centerYAnchor.constraint(equalTo: viewForShapeLayer.centerYAnchor, constant: 43),
            increaseDayCountButton.widthAnchor.constraint(equalToConstant: 40),
            increaseDayCountButton.heightAnchor.constraint(equalToConstant: 20),
            
            deleteHabitButton.widthAnchor.constraint(equalToConstant: 20),
            viewForShapeLayer.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func createProgressBar() {
        let trackLayer = CAShapeLayer ()
        let circularPath = UIBezierPath (arcCenter: CGPointMake(CGFloat(UIScreen.main.bounds.width / 5.77),
                                                                CGFloat(59)), radius: 35,
                                         startAngle: -CGFloat.pi / 2,
                                         endAngle: 2 * CGFloat.pi,
                                         clockwise:  true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 14
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        contentView.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.180293411, green: 0.7328081727, blue: 0.09719144553, alpha: 1)
        shapeLayer.lineWidth = 14
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        contentView.layer.addSublayer (shapeLayer)
        contentView.addGestureRecognizer (UITapGestureRecognizer (target: self, action: #selector (handleTap)))
    }
    
    @objc private func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc private func btnTap() {
      print("+1")
    }
    
    @objc private func presentAlertAction() {
        delegate?.presentAlert(from: self)
    }
}
