//
//  CityInputViewController.swift
//  Weather Assignment Exercise
//
//  Created by Jayant on 12/03/22.
//

import UIKit


class CityInputViewController: UIViewController {
    
    // MARK: @IBOutlet & Properties
    @IBOutlet weak var txtFieldCity: UITextField!
    private let loadingViewController = LoadingViewController()
    
    //MARK: - viewModel
    private let viewModel = CityInputViewModel()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtFieldCity.resignFirstResponder()
    }
    
    //MARK: Custom Methods
    private func navigateToWeatherListVC(weatherResponse: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            if let weatherListVC = self?.storyboard?.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController {
                weatherListVC.weatherDetails = weatherResponse
                self?.navigationController?.pushViewController(weatherListVC, animated: true)
            }
        }
    }
    
    //MARK: @IBActions
    @IBAction func lookupCityClicked(sender: AnyObject) {
        viewModel.fetchWeather(city: txtFieldCity.text)
    }
}


//MARK: LoginProtocol
extension CityInputViewController: CityInputProtocol {
    
    func showLoader() {
        add(loadingViewController)
    }
    
    func hideLoader() {
        loadingViewController.remove()
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        navigateToWeatherListVC(weatherResponse: weather)
    }
    
    func showAlertMsg(msg: String) {
        DispatchQueue.main.async {
            self.showAlert(msg: msg)
        }
    }
}

