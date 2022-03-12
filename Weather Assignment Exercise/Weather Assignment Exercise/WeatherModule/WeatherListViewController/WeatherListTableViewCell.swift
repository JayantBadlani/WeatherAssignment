//
//  WeatherListTableViewCell.swift
//  Weather Assignment Exercise
//
//  Created by Jayant on 12/03/22.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    
    // MARK: @IBOutlet & Properties
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(weather:List?) {
        if let details = weather?.weather?.first {
            lblWeather.text = details.weatherDescription ?? ""
        }
        if let temp = weather?.main?.getTemperature {
            lblTemperature.text = temp
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
