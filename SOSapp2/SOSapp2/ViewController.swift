//
//  ViewController.swift
//  SOSapp
//
//  Created by faizan on 13/06/16.
//  Copyright © 2016 faizan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
import MessageUI


class ViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    var manager = CLLocationManager()
    var address: String = ""
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupmusic()
        // collect user location
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    @IBAction func sendLocationTapped(sender: AnyObject) {
       
        //  save emergency contacts as string array
        var recipient:[String] = ["",""]
        let contacts = [Contact]()
        for (index,item) in contacts.enumerate() {
            
            recipient[index] = (item.valueForKey("number") as? String)!
            //for testing only
            print(recipient[index])
            
        }
        // sendinng location to emergency contacts
         let controller = MFMessageComposeViewController()
         if (MFMessageComposeViewController.canSendText()) {
            
         controller.body = self.address
         controller.recipients = recipient
         controller.messageComposeDelegate = self
         self.presentViewController(controller, animated: true, completion: nil)
            
         }
        
    }
    
    @IBAction func helpTapped(sender: AnyObject) {
        // playing emergency  siren
        
        if (audioPlayer.playing) {
            // for stop siren when again help button tapped
            audioPlayer.stop()
        }
        else{
        audioPlayer .play()
        }
    }
    
    @IBAction func callTapped(sender: AnyObject) {
        
        // call the police
        let url:NSURL = NSURL(string: "tel://100")!
        UIApplication.sharedApplication().openURL(url)
        
    }
   
    func setupmusic () {
       let path = NSBundle.mainBundle().resourcePath!+"/Siren.mp3"
        let soundurl: NSURL = NSURL.fileURLWithPath(path)
            do {
                // play audio for infinite loop
                try audioPlayer = AVAudioPlayer(contentsOfURL:soundurl)
                audioPlayer.numberOfLoops = -1
            }
            catch {
                
            }
        }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var userLocation = CLLocation()
        userLocation = locations[0]
        manager.stopUpdatingLocation()
        
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        // for testing only
        print(location.latitude, location.longitude)
        
        // get address from cordinates
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation, completionHandler: { (placemark, error) -> Void in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if placemark!.count > 0 {
                let placemark = placemark![0] as CLPlacemark
                self.address = placemark.name! + "," + placemark.subLocality! + "," + placemark.locality! + "," + placemark.country! + "," + placemark.postalCode!
                
                // for testing only
                print(self.address)
             
            }
            else {
                print("Error with data")
            }
        })

    }
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult){
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

