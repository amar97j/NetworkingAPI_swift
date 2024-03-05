//
//  ViewController.swift
//  NetworkingAPI
//
//  Created by Amora J. F. on 04/03/2024.
//

import UIKit
import SnapKit
import Alamofire
import Eureka

class PetViewController: UITableViewController {
    var pets: [Pet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchPetsData()
        setUpNav()
        setupNavigationBar()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPet = pets[indexPath.row]
        showPetDetails(for: selectedPet)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row] 
            NetworkManager.shared.deletePet(petID: petToDelete.id) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        self?.pets.remove(at: indexPath.row)

                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        print("error")
                    }
                }
            }
        }
    }

    func fetchPetsData() {
        NetworkManager.shared.fetchPets { fetchedPets in
            DispatchQueue.main.async {
                self.pets = fetchedPets ?? []
                self.tableView.reloadData()
            }
        }
    }

    func showPetDetails(for pet: Pet) {
        let petDetailsVC = DetailPetController()
        petDetailsVC.pet = pet
        navigationController?.pushViewController(petDetailsVC, animated: true)
    }

    func setUpNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPetTapped))
    }

    @objc private func addPetTapped() {
        let navigationController = UINavigationController(rootViewController: AddPetViewController())
        present(navigationController, animated: true, completion: nil)
    }
}
