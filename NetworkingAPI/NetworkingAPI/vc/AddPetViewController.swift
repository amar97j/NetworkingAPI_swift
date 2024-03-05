//
// AddPetViewController.swift
// NetworkingAPI
//
// Created by Amora J. F. on 05/03/2024.
//

import UIKit
import Eureka

class AddPetViewController: FormViewController {

    enum Tag: String {
        case name, age, gender, adopted, image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }

    private func setupForm() {
        form +++ Section("Add New Pet")
        <<< TextRow(Tag.name.rawValue) { row in
            row.title = "Pet Name"
            row.placeholder = "Enter Pet Name"
            row.add(rule: RuleRequired())
        }
        <<< IntRow(Tag.age.rawValue) { row in
            row.title = "Pet Age"
            row.placeholder = "Enter Pet Age"
            row.add(rule: RuleRequired())
        }
        <<< TextRow(Tag.gender.rawValue) { row in
            row.title = "Gender"
            row.placeholder = "Enter Pet Gender"
            row.add(rule: RuleRequired())
        }
        <<< SwitchRow(Tag.adopted.rawValue) { row in
            row.title = "Adopted"
        }
        <<< URLRow(Tag.image.rawValue) { row in
            row.title = "Pet Image"
            row.placeholder = "Enter Pet Image URL"
            row.add(rule: RuleRequired())
        }

        form +++ Section("")
        <<< ButtonRow() { row in
            row.title = "Add Pet"
            row.onCellSelection { _, _ in
                self.submitTapped()
            }
        }
    }

    @objc func submitTapped() {
        let errors = form.validate()
        guard errors.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Please fill out all fields.")
            return
        }

        let name = form.values()[Tag.name.rawValue] as? String ?? ""
        let age = form.values()[Tag.age.rawValue] as? Int ?? 0
        let gender = form.values()[Tag.gender.rawValue] as? String ?? ""
        let adopted = form.values()[Tag.adopted.rawValue] as? Bool ?? false
        let imageURL = (form.values()[Tag.image.rawValue] as? URL)?.absoluteString ?? ""

        let pet = Pet(id: 0, name: name, gender: gender, adopted: adopted, age: age, image: imageURL)

        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Error adding pet")
                }
            }
        }
    }

    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
