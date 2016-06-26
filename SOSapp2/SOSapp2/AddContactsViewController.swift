//
//  AddContactsViewController.swift
//  SOSapp
//
//  Created by faizan on 14/06/16.
//  Copyright © 2016 faizan. All rights reserved.
//

import UIKit
import CoreData

class AddContactsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contatTextField: UITextField!
    var newContact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (newContact != nil) {
           nameTextField.text = newContact?.name
           contatTextField.text = newContact?.number
        }
    }

    @IBAction func saveTapped(sender: AnyObject) {
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        if (newContact != nil) {
            // update a existing contact
            newContact?.setValue(self.nameTextField.text, forKey: "name")
            newContact?.setValue(self.contatTextField.text, forKey: "number")
        } else {
            // create new contact
            let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context)
            newContact.setValue(self.nameTextField.text, forKey: "name")
            newContact.setValue(self.contatTextField.text, forKey: "number")
        }
        do {
            // save object
            try context.save()
            
        }
        catch {
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
