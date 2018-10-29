//
//  TodaysOutfitViewController.swift
//  Dress Code
//
//  Created by Sneha Shekar on 2018-04-24.
//  Copyright © 2018 Sneha Shekar. All rights reserved.
//

import UIKit

class TodaysOutfitViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var dressImageView: UIImageView!
    
    var clothing = Array<JSON>()
    var initJSON = Array<Clothes>()
    var specs: String = ""
    
    var cityName: String = ""
    var forecasts: Array<ForecastData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //self.tempLabel.text = "4"
        //self.loadMyImage(iconCode: 701)
        
        // Get content for settings
        self.specs = UserDefaults.standard.string(forKey: "specs")!
        self.cityName = UserDefaults.standard.string(forKey: "city")!
        
        //setCity based on settings/default
        self.setCity(city: cityName)

        //load file
        
        if let file = Bundle(for: AppDelegate.self).path(forResource: "clothes3", ofType: "json")
        {
            let data = NSData(contentsOfFile: file) as! Data
            let json = JSON(data: data)
            self.clothing = json["Clothes"].arrayValue
        }
        
        //generate outfit
        let outfit = todaysOutfitGenerator(data: clothing)
        
        //display outfit
        if (specs == "dress" || specs == "jumpsuit"){
            
            dressImageView!.image = UIImage(named: outfit[0].image)
            
        } else if (specs == "topBottom"){
            
            topImageView!.image = UIImage(named: outfit[0].image)
            bottomImageView!.image = UIImage(named: outfit[1].image)
            
        }
    
    }
    
    //refresh outfit (call generator again) (use IBOutlet Action)
    @IBAction func refreshPressed(_ sender: Any) {
        
        let outfit = todaysOutfitGenerator(data: clothing)
        
        if (specs == "dress" || specs == "jumpsuit") {
            
            dressImageView!.image = UIImage(named: outfit[0].image)
            
        }else if (specs == "topBottom"){
            
            topImageView!.image = UIImage(named: outfit[0].image)
            bottomImageView!.image = UIImage(named: outfit[1].image)
            
        }
    }
    
    func todaysOutfitGenerator(data: Array<JSON>) -> Array<Clothes> {
      
        var topsArray = Array<Clothes>()
        var bottomsArray = Array<Clothes>()
        var todaysOutfit = Array<Clothes>()
        var dress = Array<Clothes>()
        var jumpsuit = Array<Clothes>()
        
        if (specs == "dress"){
            
            dress = convToArray(data: data[3])
            
            let rand = Int(arc4random_uniform(UInt32(dress.count)))

            todaysOutfit.append(dress[rand])
            
        } else if (specs == "topBottom"){
            
            topsArray = convToArray(data: data[0])
            bottomsArray = convToArray(data: data[1])
            
            //random number generator for outfit
            let rand1 = Int(arc4random_uniform(UInt32(topsArray.count)))
            let rand2 = Int(arc4random_uniform(UInt32(bottomsArray.count)))
            
            //add to today's outfit
            todaysOutfit.append(topsArray[rand1])
            todaysOutfit.append(bottomsArray[rand2])
            
        } else if (specs == "jumpsuit"){
            
            jumpsuit = convToArray(data: data[4])
            let rand = Int(arc4random_uniform(UInt32(jumpsuit.count)))
            todaysOutfit.append(jumpsuit[rand])
        }
        
        
        return todaysOutfit
    }
    
    func whatSeason(date: String){
        

    }
    
    //this takes in JSON from the category level
    func convToArray (data: JSON) -> Array<Clothes> {
        
        initJSON = Array<Clothes>()
        let clothesDataArray = data["items"].array!
        
        for data in clothesDataArray {
            initJSON.append(Clothes(data: data))
        }
        
        return initJSON
    }
    
    func setCity(city: String)
    {
        self.cityName = city
        UserDefaults.standard.set(city, forKey: "city")
        self.title = cityName + "'s Weekly Forecast"
        
        if let forecastURL = WeatherURLManager.getCityWeatherURL(city: city)
        {
            let session = URLSession.shared
            
            let task = session.dataTask(with: forecastURL)
            { (data, response, error) -> Void in
                
                if data != nil
                {
                    // Load Temperature
                    let weatherData = JSON(data: data!)
                    let tempValue = weatherData["main"]["temp"].intValue
                    self.loadMyImage(data: weatherData)
                    
                    DispatchQueue.main.async
                        {	self.tempLabel.text = "\(tempValue)º"
                    }
                }

            }
            
            task.resume()
        }
    }
    
    func loadMyImage(data: JSON){
        
        let weatherArray = data["weather"].arrayValue
        let iconString = weatherArray[0]["id"].stringValue
        let iconCode = Int(iconString)!
        
        
        if (iconCode >= 300 && iconCode <= 321){
            self.weatherImageView.image = UIImage.init(named: "rain.png")
        }
        if (iconCode >= 500 && iconCode <= 531){
            self.weatherImageView.image = UIImage.init(named: "rain.png")
        }
        if (iconCode >= 600 && iconCode <= 622){
            self.weatherImageView.image = UIImage.init(named: "snow.png")
        }
        if (iconCode >= 701 && iconCode <= 781){
            self.weatherImageView.image = UIImage.init(named: "windy.png")
        }
        if (iconCode == 800){
            self.weatherImageView.image = UIImage.init(named: "sunny.png")
        }
        if (iconCode >= 801 && iconCode <= 804){
            self.weatherImageView.image = UIImage.init(named: "cloudy.png")
        }
    }

}
