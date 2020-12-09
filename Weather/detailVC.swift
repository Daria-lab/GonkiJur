//
//  detailVC.swift
//  Weather
//
//  Created by user on 28/11/2020.
//

import UIKit

class detailVC: UIViewController {
    @IBOutlet weak var city: UILabel!
    var cityName = ""

    @IBOutlet weak var temperature: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let colorTop = UIColor(red: 89/255, green: 156/255, blue: 169/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func currentWeather(city: String) {
        let url =
        "https://api.weatherapi.com/v1/current.json?key=a725e4abfbb545e787c195410202711&q=\(city)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                let temp = json["current"]["temp_c"].doubleValue
                let country = json["location"]["country"].stringValue
                let weatherURLString = "http:\(json["location"][0]["icon"].stringValue)"
                
                self.cityNameLabel.text = name
                self.temp_c.text = String(temp)
                self.countryLable.text = country
                
                let weatherURL = URL(string: weatherURLString)
                if let data = try? Data(contentsOf: weatherURL!) {
                    self.imageWeather.image = UIImage(data:data)
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
            
            /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
