//
//  ViewController.swift
//  CR Chest Tracker
//
//  Created by Nicholas Tan on 19/02/2017.
//  Copyright © 2017 Nicholas Tan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedObjectContext : NSManagedObjectContext!

    @IBAction func silver(_ sender: AnyObject) {
    }
    @IBAction func golden(_ sender: AnyObject) {
    }
    @IBAction func giant(_ sender: AnyObject) {
    }
    @IBAction func magical(_ sender: AnyObject) {
    }
    @IBAction func superMagical(_ sender: AnyObject) {
    }
    @IBAction func legend(_ sender: AnyObject) {
    }
    @IBAction func deleteChest(_ sender: AnyObject) {
    }
    @IBOutlet weak var prevChest1: UIImageView!
    @IBOutlet weak var prevChest2: UIImageView!
    @IBOutlet weak var prevChest3: UIImageView!
    @IBOutlet weak var prevChest4: UIImageView!
    @IBOutlet weak var chest1: UIImageView!
    @IBOutlet weak var chest2: UIImageView!
    @IBOutlet weak var chest3: UIImageView!
    @IBOutlet weak var chest4: UIImageView!
    @IBOutlet weak var chest5: UIImageView!
    @IBOutlet weak var chest6: UIImageView!
    @IBOutlet weak var percent1: UILabel!
    @IBOutlet weak var percent2: UILabel!
    @IBOutlet weak var percent3: UILabel!
    @IBOutlet weak var percent4: UILabel!
    @IBOutlet weak var percent5: UILabel!
    @IBOutlet weak var percent6: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignBackground()
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        let chest = Chest(context: managedObjectContext)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assignBackground() {
        let background = UIImage(named: "Background")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }


}

