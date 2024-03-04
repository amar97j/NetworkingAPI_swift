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
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Pet Details"
        
        setupUI()
        updateUI()
        
        if let imageUrl = URL(string: pet?.image ?? "") {
            imageView.kf.setImage(with: imageUrl)
        }
    }
    
    private func setupUI() {
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(adoptedLabel)
        view.addSubview(ageLabel)
        view.addSubview(genderLabel)
        view.addSubview(imageView)
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        adoptedLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(adoptedLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
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
