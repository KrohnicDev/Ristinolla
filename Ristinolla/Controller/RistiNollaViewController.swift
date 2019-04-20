//
//  ViewController.swift
//  Ristinolla
//
//  Created by Joonas Junttila on 11/03/2019.
//  Copyright © 2019 Joonas Junttila. All rights reserved.
//

import UIKit


class RistiNollaViewController: UIViewController {
    
    // MARK - Properties
    private var ruudut = [UIButton]()
    private var alustetaanko = false
    var peli: Peli!
    
    // MARK - Outlets
    @IBOutlet weak var vuoroLabel: UILabel!
    @IBOutlet weak var rivit: UIStackView!
    
    // MARK - Actions
    @IBAction func aloitaAlustaPainettu(_ sender: UIButton) {
        aloitaAlusta()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
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
        
        if peli.voittaja != .tyhjä {
            alustetaanko = true
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if peli == nil {
            peli = Peli.init(aloittaja: .risti, korkeus: 3, leveys: 3, voitto: 3)
        }
        
        luoRuudukko()
        aloitaAlusta()
        
    }
    
    
    func asetaVuoroteksti(){
        var teksti: String
        
        // käsitellään mahdollinen voitto
        if peli.voittaja == .nolla {
            teksti = "Sininen voitti!"
        } else if peli.voittaja == .risti {
            teksti = "Punainen voitti!"
        }
        
        // jos ei voittoa, vaihdetaan pelivuoroa
        else {
            switch peli.vuoro {
            case .risti:
                teksti = "Vuorossa: Punainen"
            case .nolla:
                teksti = "Vuorossa: Sininen"
            }
        }
        
        vuoroLabel.text = teksti
    }
    
    func aloitaAlusta(){
        alustetaanko = false
        peli.aloitaAlusta()
        asetaVuoroteksti()
        for button in ruudut {
            button.backgroundColor = UIColor.gray
        }
    }
    
    func luoRuudukko(){
        for y in 1 ... peli.ruudukonKorkeus {
            
            var rivinPainikkeet = [UIButton]()
            
            for x in 1 ... peli.ruudukonLeveys {
                let painikeNro = x + (y - 1) * peli.ruudukonLeveys
                let painike = UIButton()
                painike.tag = painikeNro
                painike.translatesAutoresizingMaskIntoConstraints = false
                painike.backgroundColor = UIColor.gray
                painike.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
                
                // ruuduille voidaan asettaa numerot näkyviin tästä
//                painike.setTitle("\(painikeNro)", for: .normal)
                
                ruudut.append(painike)
                rivinPainikkeet.append(painike)
                
            }
            
            let rivi = UIStackView(arrangedSubviews: rivinPainikkeet)
            rivi.axis = .horizontal
            rivi.spacing = rivit.spacing
            rivi.distribution = .fillEqually
            rivi.translatesAutoresizingMaskIntoConstraints = false
            
            rivit.addArrangedSubview(rivi)
        }
    }
    
    

}


