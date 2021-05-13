//
//  WeatherTableViewCell.swift
//  DarkSky
//
//  Created by Namrata Akash on 12/05/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var dayLabel:UILabel!
    @IBOutlet var highTempLabel:UILabel!
    @IBOutlet var lowTempLabel:UILabel!
    @IBOutlet var iconimageView:UIImageView!
    var data:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    func configure(with model: DailyWeather) {
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = "\(Int((model.temp.min)-273.15))°"
        self.highTempLabel.text = "\(Int((model.temp.max)-273.15))°"
        
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
        self.iconimageView.contentMode = .scaleAspectFill
        let data = model.weather
        
        for i in data {
            if i.icon == "01d" {
                iconimageView.image = UIImage(named: "Clear")
            }
            else  if i.icon == "02n"{
                iconimageView.image = UIImage(named: "Cloud")
            }
            else  if i.icon == "04n"{
                iconimageView.image = UIImage(named: "Rain")
            }
            else {
                iconimageView.image = UIImage(named: "Clear")
            }
            
        }
            
    }
        
        
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        return formatter.string(from: inputDate)
    }
   
}
