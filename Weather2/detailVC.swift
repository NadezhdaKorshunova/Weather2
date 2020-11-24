//
//  detailVC.swift
//  Weather2
//
//  Created by user on 24/11/2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailVC: UIViewController {
    
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var IconLabel: UIImageView!
    @IBOutlet weak var LatLabel: UILabel!
    @IBOutlet weak var LonLabel: UILabel!
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    
    var cityName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather(name: cityName)

        // Do any additional setup after loading the view.
    }
    
    func currentWeather(name: String) {
        let url = "https://api.weatherapi.com/v1/current.json?key=\(token)&q=\(name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url as! URLConvertible, method: .get).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let name = json["location"]["name"].stringValue
                    let temp = json["current"]["temp_c"].doubleValue
                    let date = json["location"]["localtime"].stringValue
                    self.lat = json["location"]["lat"].doubleValue
                    self.lon = json["location"]["lon"].doubleValue
                    

                    self.CityLabel.text = name
                    self.TempLabel.text = String(temp) + "° C"
                    self.DateLabel.text = date
                    self.LatLabel.text = String(self.lat)
                    self.LonLabel.text = String(self.lon)

                    let iconString = "https:\(json["current"]["condition"]["icon"].stringValue)"
                    self.IconLabel.image = UIImage(data: try! Data(contentsOf: URL(string: iconString)!))                case .failure(let error):
                    print(error)
                }
        }
    }
    
    @IBAction func goMapVC(_ sender: Any) {
        performSegue(withIdentifier: "goMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MapVC {
            vc.lat = self.lat
            vc.lon = self.lon
            
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
