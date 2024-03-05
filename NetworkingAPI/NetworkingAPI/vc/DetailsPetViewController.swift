import UIKit
import Kingfisher
import SnapKit

class DetailPetController: UIViewController {

    var pet: Pet?

    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor.black
        return label
    }()

    let adoptedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        return label
    }()

    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        return label
    }()

    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20 // Increase corner radius for a more rounded look
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Rounded top corners
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.98, alpha: 1.0)
        title = "Pet Details"

        setupUI()
        updateUI()

        if let imageUrl = URL(string: pet?.image ?? "") {
            imageView.kf.setImage(with: imageUrl)
        }

    
    }

    
   

    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(adoptedLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(genderLabel)

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }

        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.lightGray
        view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(250)
        }
    }

    private func updateUI() {
        guard let pet = pet else {
            return
        }
        idLabel.text = "ID: \(pet.id)"
        nameLabel.text = "Name: \(pet.name)"
        adoptedLabel.text = "Adopted: \(pet.adopted ? "Yes" : "No")"
        ageLabel.text = "Age: \(pet.age)"
        genderLabel.text = "Gender: \(pet.gender)"
    }
}
