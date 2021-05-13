//
//  WeatherCollectionViewCell.swift
//  DarkSky
//
//  Created by Namrata Akash on 12/05/21.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    static let identifier = "WeatherCollectionViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell",
                     bundle: nil)
    }

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!

    func configure(with model: HourlyWeatherEntry) {
        self.tempLabel.text = "\(Int((model.temp)-273.15))°"
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.image = UIImage(named: "Clear")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

