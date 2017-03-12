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
    var nextChest : [String] = []
    var chest = Chest()
    var cycle = Cycle()
    var special = SpecialChest()
    var image = UIImage()

    @IBAction func silver(_ sender: AnyObject) {
        self.addCycle(typeOfChest: "Silver")
    }
    @IBAction func golden(_ sender: AnyObject) {
        self.addCycle(typeOfChest: "Golden")
    }
    @IBAction func giant(_ sender: AnyObject) {
        self.addCycle(typeOfChest: "Giant")
    }
    @IBAction func magical(_ sender: AnyObject) {
        self.addCycle(typeOfChest: "Magical")
    }
    @IBAction func superMagical(_ sender: AnyObject) {
        self.addCycle(typeOfChest: "SuperMagical")
    }
    @IBAction func legend(_ sender: AnyObject) {
        self.addCycle(typeOfChest: "Legend")
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
            self.refresh()
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
        self.getData(entity: "Cycle")
        self.getData(entity: "SpecialChest")
        self.prevCycle()
        self.showCycle()
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
    
    func prevCycle() {
        if cycles.count > 0 {
            cycle = cycles[0]
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
    
    func showCycle() {
        var zero = 0
        var one = 0
        var two = 0
        var three = 0
        var four = 0
        var five = 0
        var sum = 0
        var zeroP = 0.0
        var oneP = 0.0
        var twoP = 0.0
        var threeP = 0.0
        var fourP = 0.0
        var fiveP = 0.0
        
        if cycles.count > 0 {
            self.calculateNext()
            for i in 0..<nextChest.count {
                if nextChest[i] == "0" {
                    zero += 1
                }
                else if nextChest[i] == "1" {
                    one += 1
                }
                else if nextChest[i] == "2" {
                    two += 1
                }
                else if nextChest[i] == "3" {
                    three += 1
                }
                else if nextChest[i] == "4" {
                    four += 1
                }
                else if nextChest[i] == "5" {
                    five += 1
                }
            }
            
            sum = zero + one + two + three + four + five
            zeroP = Double(zero)/Double(sum)*100
            oneP = Double(one)/Double(sum)*100
            twoP = Double(two)/Double(sum)*100
            threeP = Double(three)/Double(sum)*100
            fourP = Double(four)/Double(sum)*100
            fiveP = Double(five)/Double(sum)*100
            
            print("Silver chest percentage: \(zeroP)")
            print("Golden chest percentage: \(oneP)")
            print("Giant chest percentage: \(twoP)")
            print("Magical chest percentage: \(threeP)")
            print("Super Magical chest percentage: \(fourP)")
            print("Legendary chest percentage: \(fiveP)")
            
            var list = [(zeroP, "0"), (oneP, "1"), (twoP, "2"), (threeP, "3"), (fourP, "4"), (fiveP, "5")]
            list = list.sorted {$0 > $1}
            
            let listP = list.map { $0.0 }
            let listT = list.map { $0.1 }
            
            for type in 0..<listT.count {
                if listT[type] == "0" {
                    image = #imageLiteral(resourceName: "SilverChest")
                }
                else if listT[type] == "1" {
                    image = #imageLiteral(resourceName: "GoldenChest")
                }
                else if listT[type] == "2" {
                    image = #imageLiteral(resourceName: "GiantChest")
                }
                else if listT[type] == "3" {
                    image = #imageLiteral(resourceName: "MagicalChest")
                }
                else if listT[type] == "4" {
                    image = #imageLiteral(resourceName: "SuperMagicalChest")
                }
                else {
                    image = #imageLiteral(resourceName: "LegendChest")
                }
                
                var temp : String = String(format: "%.2f", listP[type])
                temp = temp + "%"
                
                if type == 0 {
                    chest1.image = image
                    percent1.text = temp
                }
                else if type == 1 {
                    chest2.image = image
                    percent2.text = temp
                }
                else if type == 2 {
                    chest3.image = image
                    percent3.text = temp
                }
                else if type == 3 {
                    chest4.image = image
                    percent4.text = temp
                }
                else if type == 4 {
                    chest5.image = image
                    percent5.text = temp
                }
                else {
                    chest6.image = image
                    percent6.text = temp
                }
            }
            
        }
        else {
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
    }
    
    func addCycle(typeOfChest:String) {
        let temp = Cycle(context: context)
        if typeOfChest == "Silver" {
            temp.current = "0"
        }
        else if typeOfChest == "Golden" {
            temp.current = "1"
        }
        else if typeOfChest == "Giant" {
            temp.current = "2"
        }
        else if typeOfChest == "Magical" {
            temp.current = "3"
        }
        else if typeOfChest == "SuperMagical" {
            temp.current = "4"
        }
        else if typeOfChest == "Legend" {
            temp.current = "5"
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        self.refresh()
    }
    
    func refresh() {
        self.getData(entity: "Cycle")
        self.calculateNext()
        self.prevCycle()
        self.showCycle()
    }
    
    func calculateNext() {
        var count = 0
        nextChest.removeAll()
        for var chest in 0..<chests.count {
            for cycle in 0..<cycles.count {
                if cycles[cycle].current != chests[chest].type {
                    break
                }
                else {
                    if cycle == cycles.count-1 {
                        count += 1
                        if chest != chests.count-1 {
                            nextChest.append(chests[chest+1].type!)
                        }
                        else {
                            nextChest.append(chests[0].type!)
                        }
                    }
                    if chest == chests.count-1 {
                        break
                    }
                    chest += 1
                }
            }
        }
        print(count)
    }
    
    func exportCSV(file: String) -> Bool {
        let path = Bundle.main.path(forResource: file, ofType: "csv")
        if file == "currentCycle" {
            if cycles.count > 0 {
                var result = "Current, \r"
                for i in cycles {
                    result = result + "\"" + (i.current)!
                    result = result + "\"" + "," + "\r"
                }
                do {
                    try result.write(toFile: path!, atomically: true, encoding: String.Encoding.utf8)
                }catch{
                    print("ERROR: Export, could not be saved in %", path!)
                }
                return true
            }
        }
        else if file == "specialChest" {
            if specials.count > 0 {
                var result = "SuperMagical, Legend, \r"
                result = result + "\"" + (special.superMagical)! + "\"" + "," + "\"" + (special.legend)! + "\"" + "\r"
                do {
                    try result.write(toFile: path!, atomically: true, encoding: String.Encoding.utf8)
                }catch{
                    print("ERROR: Export, could not be saved in %", path!)
                }
                return true
            }
        }
        return false
    }
}
