//
//  DataViewController.swift
//  Morse SOS
//
//  Created by Armaan Johal on 3/10/19.
//  Copyright © 2019 Armaan Johal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation



class ViewController: UIViewController, AVAudioPlayerDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var Map: MKMapView!
    
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    let locationManager = CLLocationManager()
    
    
    
    var audioPlayer = AVAudioPlayer()
    var lat = CLLocationDegrees()
    var long = CLLocationDegrees()
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLocationServices()
        
        locationManager.delegate = self
        
        
        /*do {
         
         audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "1500", ofType: "mp3")!))
         audioPlayer.prepareToPlay()
         
         
         }
         catch {
         
         print(error)
         }
         */
        
        let loc = locationManager.location
        lat = (loc?.coordinate.latitude)!
        long = (loc?.coordinate.longitude)!
        let location = CLLocationCoordinate2DMake((lat), (long))
        
        let span = MKCoordinateSpan.init(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region = MKCoordinateRegion(center: location, span: span)
        
        Map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Location"
        annotation.subtitle = "Location"
        
        Map.addAnnotation(annotation)
        
       // print("                                                                                   ")
       // print(lat)
       // print (long)
       // print("                                                                                      ")
        
        
    }
    
    
    
    
    
    func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            
            setupLocationManager()
            checkLocationAuthorization()
            
        }
        else {
            //Show alert that tells user that they have to turn this on
        }
        
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            Map.showsUserLocation = true
            break
        case .denied:
            //give info on how to turn on
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //give info on how to turn on
            break
        case .authorizedAlways:
            break
            
        }
        
        
        
        
    }
    
    
   
    
    @IBAction func SOS(_ sender: AnyObject) {
        //if audioPlayer.isPlaying == false {
            
            seperateDigits()
            //toggleTorch(on: true)
            
        //}
        //else{
            
            //audioPlayer.stop()
        //}
    }
    
    
    
    
    
    
    
    func seperateDigits (){
        
        
        
        let latString : String = " "+"\(lat)"
        var latIndex = latString.index(latString.startIndex, offsetBy: 0)
        while latIndex < (latString.endIndex) {
            //print(latString[latIndex])
            //print("\(latIndex)")
            testNumbers(str: latString[latIndex])
            latIndex = latString.index(after: latIndex)
        }
        
        //print(",")
        let longString : String = " "+"\(long)"
        var longIndex = longString.index(longString.startIndex, offsetBy: 0)
        while longIndex < (longString.endIndex) {
            //print(longString[longIndex])
            testNumbers(str: longString[longIndex])
            longIndex = longString.index(after: longIndex)
        }
        
        
    }
    
    
    
    
    
    func testNumbers (str: Character)  {
        
        let strn: String = "\(str)"
        print(str)
        
        if strn == "0" {
            sound(name: "morse_zero", type: "m4a")
            
        }
        else if strn == "1" {
            sound(name: "morse_one", type: "m4a")
            //print(lat)
            //print(long)
            //print(str)
            
            
        }
        else if strn == "2" {
            sound(name: "morse_two", type: "m4a")
            
        }
        else if strn == "3" {
            sound(name: "morse_three", type: "m4a")
            //print("3333333333")
        }
        else if strn == "4" {
            sound(name: "morse_four", type: "m4a")
            
        }
        else if strn == "5" {
            sound(name: "morse_five", type: "m4a")
            
        }
        else if strn == "6" {
            sound(name: "morse_six", type: "m4a")
        }
        else if strn == "7" {
            sound(name: "morse_seven", type: "m4a")
            
        }
        else if strn == "8" {
            sound(name: "morse_eight", type: "m4a")
            
        }
        else if strn == "9" {
            sound(name: "morse_nine", type: "m4a")
            
        }
        else if strn == "." {
            sound(name: "morse_dot", type: "m4a")
            
        }
        else if strn == "," {
            sound(name: "morse_comma", type: "m4a")
            
        }
        else if strn == " " {
            sound(name: "morse_space", type: "m4a")
            
        }
        
        
    }
    
    
    
    func sound (name: String, type: String) {
        
        super.viewDidLoad()
        do {
            
            print(name)
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: type)!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            sleep(6/4)
            
            
            
        }
        catch {
            
            print(error)
        }
        
    }
    
    
    
    
    
    /*func toggleTorch(on: Bool) {
        let device = AVCaptureDevice.default(for: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)))
        
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                
                if on == true {
                    device?.torchMode = .on
                } else {
                    device?.torchMode = .off
                }
                
                device?.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    */
    
   
    
    
    
    
    
    /*   func load()-> CLLocationDegrees {
     
     
     super.viewDidLoad()
     // Do any additional setup after loading the view, typically from a nib.
     
     checkLocationServices()
     
     locationManager.delegate = self
     
     
     /*do {
     
     audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "1500", ofType: "mp3")!))
     audioPlayer.prepareToPlay()
     
     
     }
     catch {
     
     print(error)
     }
     */
     
     let loc = locationManager.location
     let lat = loc?.coordinate.latitude
     let long = loc?.coordinate.longitude
     let location = CLLocationCoordinate2DMake((lat)!, (long)!)
     
     let span = MKCoordinateSpanMake(0.002, 0.002)
     let region = MKCoordinateRegion(center: location, span: span)
     
     Map.setRegion(region, animated: true)
     
     let annotation = MKPointAnnotation()
     annotation.coordinate = location
     annotation.title = "Pizza"
     annotation.subtitle = "Amazing Pizza"
     
     Map.addAnnotation(annotation)
     
     print("                                                                                     ")
     print(lat)
     print (long)
     print("                                                                                      ")
     
     return lat!
     return long!
     
     }
     
     */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* extension DataViewController: CLLocationManagerDelegate {
     
     private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: CLLocation) {
     
     let location = locations[0]
     
     let span:MKCoordinateSpan = MKCoordinateSpanMake(location.coordinate.latutude, location.coordinate.longitude)
     
     //We will be back
     }
     
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
     //We will be back
     }
     }
     
     */
    
    
    
    
    
    
    
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVMediaType(_ input: AVMediaType) -> String {
	return input.rawValue
}
