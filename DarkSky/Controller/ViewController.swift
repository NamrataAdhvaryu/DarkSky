//
//  ViewController.swift
//  DarkSky
//
//  Created by Namrata Akash on 12/05/21.
//

import UIKit
import CoreLocation
import CoreData

// PLAN: -

// Location :CoreLocation
// table view
//custom cell: collection view
// API / request to get the data

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet var table :UITableView!
   let manager = CoredataManager()


    var models = [DailyWeather]()
    var hourlymodels = [HourlyWeatherEntry]()
    var current: CurrentWeather?
    let locationManager = CLLocationManager()
    var currentlocation : CLLocation?
    var currentlocations:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        //register 2 nibs
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
       let data = manager.fetchWeatherData()
        
        setUI()
    }
    
    
    
    
    func setUI()  {
       
        
        
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    // Location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty , currentlocation == nil {
            currentlocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherforLocation()
        }
    }
    
    func requestWeatherforLocation() {
        guard let currentlocation = currentlocation else {
            return
        }
        let long = currentlocation.coordinate.longitude
        let lat = currentlocation.coordinate.latitude
        
//        manager.createWeatherData(lat: Float(lat), long: Float(long))
        let url = "\(Constants().API_URL)lat=\(lat)&lon=\(long)&exclude=minutely&appid=\(Constants().API_KEY)"
        
        
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // Convert data to models/some object
            
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
             print(result)
            let entries = result.daily
            self.currentlocations = result.timezone
            self.models.append(contentsOf: entries)
            
            let current = result.current
            self.current = current
            self.hourlymodels = result.hourly
            
            //update user interface
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
            }
            
        }).resume()
    }
    
    
    func createTableHeader() -> UIView {
        let headerVIew = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
    
        headerVIew.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/2))
        
        headerVIew.addSubview(locationLabel)
        headerVIew.addSubview(tempLabel)
        headerVIew.addSubview(summaryLabel)
        
        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        locationLabel.text = currentlocations
        summaryLabel.font = UIFont(name: "Bold", size: 30)
        
        guard let currentWeather = self.current else {
            return UIView()
        }
        
        tempLabel.text = "\(Int((currentWeather.temp)-273.15))°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        
        let data = current?.weather
        
        for i in data! {
            
            summaryLabel.text = i.description
            summaryLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
        }
        return headerVIew
    }
}








// MARK: -
//tableview section


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 1 cell that is collectiontableviewcell
            return 1
        }
        // return models count
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlymodels)
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            return cell
        }
        
        // Continue
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: models[indexPath.row])
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


