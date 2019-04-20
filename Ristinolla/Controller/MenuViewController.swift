//
//  MenuViewController.swift
//  Ristinolla
//
//  Created by Joonas Junttila on 20/04/2019.
//  Copyright © 2019 Joonas Junttila. All rights reserved.
//

import Foundation
import UIKit

// MARK - Constants
let LEVEYS_TAG = 1
let KORKEUS_TAG = 2
let VOITTO_TAG = 3
let ALOITUS_SEGUE = "aloitaPeli"

class MenuViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet weak var leveysLabel: UILabel!
    @IBOutlet weak var korkeusLabel: UILabel!
    @IBOutlet weak var voittoSarjaLabel: UILabel!
    @IBOutlet weak var aloittajaValitsin: UISegmentedControl!
    
    // MARK - Properties
    var voittoonVaaditaan = 3
    var valittuLeveys = 3
    var valittuKorkeus = 3
    var valittuAloittaja: Vuoro!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asetaLabelit()
    }
    
    // MARK - Actions
    @IBAction func slideriaSiirrettiin(_ sender: UISlider) {
        
        switch sender.tag {
        case LEVEYS_TAG:
            valittuLeveys = Int(sender.value)
        case KORKEUS_TAG:
            valittuKorkeus = Int(sender.value)
        case VOITTO_TAG:
            voittoonVaaditaan = Int(sender.value)
        default:
            break
        }
        
        asetaLabelit()
    }
    
    func asetaLabelit(){
        leveysLabel.text = "\(valittuLeveys) ruutua"
        korkeusLabel.text = "\(valittuKorkeus) ruutua"
        voittoSarjaLabel.text = "\(voittoonVaaditaan) peräkkäin"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch aloittajaValitsin.selectedSegmentIndex {
        case 0:
            valittuAloittaja = .risti
        case 1:
            valittuAloittaja = .nolla
        default:
            break
        }
        
        let destinationVC = segue.destination as! RistiNollaViewController
        
        if segue.identifier == ALOITUS_SEGUE {
            destinationVC.game = Game.init(aloittaja: valittuAloittaja, korkeus: valittuKorkeus, leveys: valittuLeveys, voitto: voittoonVaaditaan)
        }
        
    }
    
}
