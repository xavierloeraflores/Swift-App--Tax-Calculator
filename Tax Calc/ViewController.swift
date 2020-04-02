//
//  ViewController.swift
//  Tax Calc
//
//  Created by Xavier Loera Flores on 6/5/18.
//  Copyright © 2018 Xavier Loera Flores. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    var price = ""
    var numprice = 0.0
    var tax = 0.0925
    var taxadd = 0.0
    var taxprice = 0.0
    var decimal = false
    var decimalcount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.register(defaults: [String : Any]())
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gradient()
        let userDefaults = UserDefaults.standard
        let taxstring = userDefaults.string(forKey: "settings_tax")
        if taxstring != nil {
            let usertax = Double(taxstring!)!/100.0
            tax = usertax
        } else {
            tax = 0.0925
        }

    }
    
    
    
    
    @IBOutlet weak var labeltax: UILabel!
    
    
    
    
    
    @IBOutlet weak var userin: UILabel!
    @IBOutlet weak var taxout: UILabel!
    
 
    @IBOutlet var buttons: [UIButton]!
    
    func usertype(withNum num:String){
        if (decimalcount < 3  ) {
        if (num != "."){
            price+=num
        calc()
        if( decimalcount > 0 ){
            decimalcount+=1
        }
        }
        
        if (num == "." && decimalcount == 0){
            price+=num
            decimalcount+=1
        }
        
        }}

    func updateLabel(){
        userin.text =  "$" + String(price)
        taxout.text = "$" + String(format: "%.2f" , taxprice)
        labeltax.text = "$" + String(format: "%.2f" , taxadd)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button(_ sender: UIButton) {
        if (decimalcount != 3){
        let numin = sender.currentTitle
        usertype(withNum: numin!)
        }}
    func calc() {
        numprice = Double(price)!
        taxadd = round(1000.0 * (numprice * tax)) / 1000.0
        taxprice = numprice + taxadd
        updateLabel()
    }
    
    
    @IBAction func clear(){
    price = "0.00"
    calc()
    price = ""
        decimalcount = 0
        decimal = false
        
    }
    
    func gradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    

    
}

