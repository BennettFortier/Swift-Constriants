//
//  ViewController.swift
//  AutoLayout
//
//  Created by Todd Sproull on 9/10/18.
//  Copyright © 2018 Todd Sproull. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var PlayButton: UIButton!
    
    @IBOutlet weak var happyLevel: UILabel!
    @IBOutlet weak var feedButton: UIButton!
    
    @IBOutlet weak var happyBar: DisplayView!
    @IBOutlet weak var hungerBar: DisplayView!
    @IBOutlet weak var hungerLevel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var window: UIView!
    var currentAnimal = Animal()
    var dog = Animal(name: "dog")
    var cat = Animal(name: "cat")
    var bird = Animal(name: "bird")
    var fish = Animal(name: "fish")
    var bunny = Animal(name: "bunny")
    var timer = Timer()
    var warning: Bool = false
    var dead: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeAnimal(newAnimal: bird)
        scheduledTimerWithTimeInterval()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
 
    
    @IBAction func playMe(_ sender: UIButton) {
        if !dead {
            currentAnimal.addHappy()
            currentAnimal.subHungry()
            updateScreen()
        }
        else {
            deadMessage()
        }
    }
    @IBAction func feedMe(_ sender: UIButton) {
        if !dead {
            currentAnimal.addHungry()
            updateScreen()
        }
        else {
            deadMessage()
        }
    }
    
    @IBAction func changeToCat(_ sender: UIButton) {
        if !dead {
            changeAnimal(newAnimal: cat)
        }
        else {
            deadMessage()
        }
    }
    
    @IBAction func changeToDog(_ sender: UIButton) {
        if !dead {
            changeAnimal(newAnimal: dog)
        }
        else {
            deadMessage()
        }
    }
    @IBAction func changeToBird(_ sender: UIButton) {
        if !dead {
            changeAnimal(newAnimal: bird)
        }
        else {
            deadMessage()
        }
    }
    @IBAction func changeToBunny(_ sender: UIButton) {
        if !dead {
            changeAnimal(newAnimal: bunny)
        }
        else {
            deadMessage()
        }
    }
    @IBAction func changeToFish(_ sender: UIButton) {
        if !dead {
            changeAnimal(newAnimal: fish)
        }
        else {
            deadMessage()
        }
    }
    //Updates the UI of screen
    func updateScreen(){
        let hunger:Double = Double(currentAnimal.hungryLevel)
        let happy:Double = Double(currentAnimal.happyLevel)
        hungerLevel.text = String(hunger)
        happyLevel.text = String(happy)
        happyBar.color = currentAnimal.color
        hungerBar.color = currentAnimal.color

        var hungryBarVal = hunger/10
        var happyBarVal = happy/10
        
        if  hungryBarVal > 10{
            hungryBarVal = 10
        }
        if happyBarVal > 10{
            happyBarVal = 10
        }
        hungerBar.value = CGFloat(hungryBarVal)
        happyBar.value = CGFloat(happyBarVal)
    }
    //Save your animal's stats before updating to new animal
    func saveAnimal(){
        if currentAnimal.name == "dog" {
            dog = currentAnimal
        }
        else if currentAnimal.name == "cat" {
            cat = currentAnimal
        }
        else if currentAnimal.name == "bird" {
            bird = currentAnimal
        }
        else if currentAnimal.name == "fish" {
            fish = currentAnimal
        }
        else if currentAnimal.name == "bunny" {
            bunny = currentAnimal
        }
        
    }
    //Update current Animal to new Animal
    func changeAnimal(newAnimal:Animal){
        saveAnimal()
        currentAnimal = newAnimal
        currentAnimal.setView()
        photo.image = currentAnimal.image
        window.backgroundColor = currentAnimal.color
        updateScreen()
    }
    //Animal Class
    class Animal {
        var name: String
        var happyLevel: Float
        var hungryLevel: Float
        var color: UIColor
        var image: UIImage
        init(name: String){
            self.name = name
            self.happyLevel = 0
            self.hungryLevel = 0
            self.color = UIColor.yellow
            self.image = UIImage(named: name)!
            
        }
        convenience init(){
            self.init(name: "bird")
        }
        func addHappy(){
            if  self.hungryLevel>0 {
                self.happyLevel += 1
            }
        }
        func subHappy(){
            if self.happyLevel > 0 {
                
                self.happyLevel-=1
            }
        }
        func getHappy() -> Float{
            return self.happyLevel
        }
        func addHungry(){
         
                self.hungryLevel += 1
            
        }
        func subHungry(){
            if self.hungryLevel>0 {
                self.hungryLevel-=1
            }
        }
        func getHungry() -> Float{
            return self.hungryLevel
        }
        func setView(){
            if self.name == "bird" {
                self.color = UIColor.yellow
            }
            else if self.name == "dog" {
                self.color = UIColor.red
            }
            else if self.name == "cat" {
                self.color = UIColor.blue
            }
            else if self.name == "bunny" {
                self.color = UIColor.orange
            }
            else if self.name == "fish" {
                self.color = UIColor.purple
            }
            self.image = UIImage(named: self.name)!
        }
        func getColor() -> UIColor {
            return self.color
        }
        
    }
    //Creative Portion
    func deadMessage(){
        let title = "Too late!"
        let message = "Sorry but your pet is dead, restart the game to get a new pet"
        alert(title : title, message: message)
    }
    @objc func isPetDead(){
        if dead {
            timer.invalidate()
        }
        else if currentAnimal.hungryLevel == 0 {
            if warning {
                dead = true
            }
            else{
                warning = true
            }
            if dead {
                let title = "Dead!"
                let message = "Your current pet is dead, take better care of him next time. Please quit the game and try again."
                alert(title : title, message: message)
            }
            else if warning {
                let title = "Warning!"
                let message = "Your current pet is dangerously low on food, feed him or he will die"
                alert(title : title, message: message)
            }
        }
        else{
            currentAnimal.hungryLevel -= 0.5
            warning = false
            dead = false
            updateScreen()
        }
    }
    
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(isPetDead), userInfo: nil, repeats: !dead)
        
    }
    

}

