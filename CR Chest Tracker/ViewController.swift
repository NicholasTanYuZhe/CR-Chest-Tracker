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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var chests : [Chest] = []
    var cycles : [Cycle] = []
    var specials : [SpecialChest] = []
    var chest = Chest()
    var cycle = Cycle()
    var special = SpecialChest()

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
        if cycles.count > 0 {
            let size = cycles.count
            cycle = cycles[size-1]
            context.delete(cycle)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                cycles = try context.fetch(Cycle.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
            if size == 1 {
                prevChest1.image = #imageLiteral(resourceName: "WoodenChest")
                prevChest2.image = #imageLiteral(resourceName: "WoodenChest")
                prevChest3.image = #imageLiteral(resourceName: "WoodenChest")
                prevChest4.image = #imageLiteral(resourceName: "WoodenChest")
                chest1.image = #imageLiteral(resourceName: "WoodenChest")
                chest2.image = #imageLiteral(resourceName: "WoodenChest")
                chest3.image = #imageLiteral(resourceName: "WoodenChest")
                chest4.image = #imageLiteral(resourceName: "WoodenChest")
                chest5.image = #imageLiteral(resourceName: "WoodenChest")
                chest6.image = #imageLiteral(resourceName: "WoodenChest")
            }
            else {
                self.prevCycle()
            }
        }
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
        self.assignBackground()
        self.getData(entity: "Chest")
        chest = chests[158]
        print("Chest: \(chest.chest!) \nType: \(chest.type!)")
        self.getData(entity: "Cycle")
        self.prevCycle()
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
    
    func getData(entity:String) {
        do {
            if entity == "Chest" {
                chests = try context.fetch(Chest.fetchRequest())
            }
            else {
                cycles = try context.fetch(Cycle.fetchRequest())
            }
        } catch {
            print("Fetching Failed")
        }
    }
    
    func deleteAllData(entity:String){
        let delAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: entity))
        do {
            try context.execute(delAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
    func prevCycle() {
        var image : UIImage
        cycle = cycles[0]
        if cycle.current != "-1" {
            if cycles.count > 0 {
                for i in 1...4 {
                    if cycles[cycles.count-i].current == "0" {
                        image = #imageLiteral(resourceName: "SilverChest")
                    }
                    else if cycles[cycles.count-i].current == "1" {
                        image = #imageLiteral(resourceName: "GoldenChest")
                    }
                    else if cycles[cycles.count-i].current == "1" {
                        image = #imageLiteral(resourceName: "GiantChest")
                    }
                    else if cycles[cycles.count-i].current == "1" {
                        image = #imageLiteral(resourceName: "MagicalChest")
                    }
                    else if cycles[cycles.count-i].current == "1" {
                        image = #imageLiteral(resourceName: "SuperMagicalChest")
                    }
                    else {
                        image = #imageLiteral(resourceName: "LegendChest")
                    }
                    
                    if i == 1 {
                        prevChest1.image = image
                    }
                    else if i == 2 {
                        prevChest2.image = image
                    }
                    else if i == 3 {
                        prevChest3.image = image
                    }
                    else {
                        prevChest4.image = image
                    }
                    
                    if cycles.count == 1 && i == 1 {
                        prevChest2.image = nil
                        prevChest3.image = nil
                        prevChest4.image = nil
                        break
                    }
                    else if cycles.count == 2 && i == 2 {
                        prevChest3.image = nil
                        prevChest4.image = nil
                        break
                    }
                    else if cycles.count == 3 && i == 3 {
                        prevChest4.image = nil
                        break
                    }
                }
            }
        }
    }
    
    func addCycle(typeOfChest:String) {
        
    }

}
