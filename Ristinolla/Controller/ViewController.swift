//
//  ViewController.swift
//  Ristinolla
//
//  Created by Joonas Junttila on 11/03/2019.
//  Copyright © 2019 Joonas Junttila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK - Properties
    let peli = Peli.init(aloittaja: .risti)
    var ruudut = [UIButton]()
    var alustetaanko = false
    
    // MARK - Outlets
    @IBOutlet weak var vuoroLabel: UILabel!
    
    //rivi 1
    @IBOutlet weak var ruutu1: UIButton!
    @IBOutlet weak var ruutu2: UIButton!
    @IBOutlet weak var ruutu3: UIButton!
    @IBOutlet weak var ruutu4: UIButton!
    @IBOutlet weak var ruutu5: UIButton!
    
    //rivi 2
    @IBOutlet weak var ruutu6: UIButton!
    @IBOutlet weak var ruutu7: UIButton!
    @IBOutlet weak var ruutu8: UIButton!
    @IBOutlet weak var ruutu9: UIButton!
    @IBOutlet weak var ruutu10: UIButton!
    
    // rivi 3
    @IBOutlet weak var ruutu11: UIButton!
    @IBOutlet weak var ruutu12: UIButton!
    @IBOutlet weak var ruutu13: UIButton!
    @IBOutlet weak var ruutu14: UIButton!
    @IBOutlet weak var ruutu15: UIButton!
    
    // rivi 4
    @IBOutlet weak var ruutu16: UIButton!
    @IBOutlet weak var ruutu17: UIButton!
    @IBOutlet weak var ruutu18: UIButton!
    @IBOutlet weak var ruutu19: UIButton!
    @IBOutlet weak var ruutu20: UIButton!
    
    // rivi 5
    @IBOutlet weak var ruutu21: UIButton!
    @IBOutlet weak var ruutu22: UIButton!
    @IBOutlet weak var ruutu23: UIButton!
    @IBOutlet weak var ruutu24: UIButton!
    @IBOutlet weak var ruutu25: UIButton!
    
    
    // MARK - Actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        if alustetaanko {
            aloitaAlusta()
            return
        }
        
        if !peli.pelaaVuoro(ruudunNumero: sender.tag) { return }
        
        // päivitetään käyttöliittymä
        switch peli.vuoro {
        case .nolla:
            sender.backgroundColor = UIColor.blue
        case .risti:
            sender.backgroundColor = UIColor.red
        }
        
        peli.vaihdaVuoro()
        asetaVuoroteksti()
        
        if peli.voittaja != .eiSelvilla {
            alustetaanko = true
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ruudut = [ruutu1, ruutu2, ruutu3, ruutu4, ruutu5,
                  ruutu6, ruutu7, ruutu8, ruutu9, ruutu10,
                  ruutu11, ruutu12, ruutu13, ruutu14, ruutu15,
                  ruutu16, ruutu17, ruutu18, ruutu19, ruutu20,
                  ruutu21, ruutu22, ruutu23, ruutu24, ruutu25]
        aloitaAlusta()
    }
    
    func asetaVuoroteksti(){
        var teksti: String
        
        // käsitellään mahdollinen voitto
        if peli.voittaja == .nolla {
            teksti = "Nolla voitti!"
        } else if peli.voittaja == .risti {
            teksti = "Risti voitti!"
        }
        
        // vaihdetaan pelivuoroa
        else {
            switch peli.vuoro {
            case .risti:
                teksti = "Vuorossa: Risti"
            case .nolla:
                teksti = "Vuorossa: Nolla"
            }
        }
        
        vuoroLabel.text = teksti
    }
    
    func aloitaAlusta(){
        alustetaanko = false
        peli.aloitaAlusta()
        asetaVuoroteksti()
        for button in ruudut {
            button.backgroundColor = UIColor.yellow
        }
    }
    
    

}


