//
//  WeatherDetailsListViewController.swift
//  Weather Assignment Exercise
//
//  Created by Jayant on 12/03/22.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    // MARK: @IBOutlet & Properties
    var weatherDetails: WeatherModel?
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = weatherDetails?.city?.name ?? "My City"
    }
}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetails?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell", for: indexPath) as? WeatherListTableViewCell else {
            return UITableViewCell() }
        
        cell.setData(weather: weatherDetails?.list?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async { [weak self] in
            if let weatherDisplayVC = self?.storyboard?.instantiateViewController(withIdentifier: "WeatherDisplayViewController") as? WeatherDisplayViewController {
                weatherDisplayVC.setData(weatherResponse: self?.weatherDetails?.list?[indexPath.row], cityName: self?.weatherDetails?.city?.name)
                self?.navigationController?.pushViewController(weatherDisplayVC, animated: true)
            }
        }
    }
}

