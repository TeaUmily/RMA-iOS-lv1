//
//  ViewController.swift
//  MyDestinations
//
//  Created by Terezija Umiljanovic on 11.05.2021..
//

import UIKit

class DestinationsHomeUIViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellReuseID: String = "displayCell"
    private var destinations: [Destination] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Moje destinacije"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadDestinationsFromUserDefaults()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let dataEntryVC = segue.destination as? AddDestinationUIController {
            dataEntryVC.delegate = self
        }
    }
}

extension DestinationsHomeUIViewController {
    private func loadDestinationsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: Destination.userDefaultsKey) {
            let decoder = JSONDecoder()
            do {
                destinations = try decoder.decode([Destination].self, from: data)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func saveDestinationsToUserDefaults() {
        let encoder = JSONEncoder()
        do {
            let data: Data = try encoder.encode(destinations)
            UserDefaults.standard.set(data, forKey: Destination.userDefaultsKey)
            UserDefaults.standard.synchronize()
        } catch {
            print(error)
        }
    }
}

extension DestinationsHomeUIViewController: AddDestinationViewControllerDelegate {
    func created(newDestination: Destination) {

        destinations.append(newDestination)
        tableView.reloadData()
        
        saveDestinationsToUserDefaults()
    }
}

extension DestinationsHomeUIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        
        let destination = destinations[indexPath.row]
        
        cell.textLabel?.text = destination.title
        //cell.detailTextLabel?.text = destination.description
        
        return cell
    }
}

