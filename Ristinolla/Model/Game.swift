//
//  Peli.swift
//  Ristinolla
//
//  Created by Joonas Junttila on 11/03/2019.
//  Copyright © 2019 Joonas Junttila. All rights reserved.
//

import Foundation

class Game {
    var vuoro: Vuoro
    var voittaja: RuudunTila = .tyhjä
    var tilanne = [RuudunTila]()
    private var viimeisinSiirto = 0
    let voittoonTarvittavaSarja: Int
    let ruudukonLeveys: Int
    let ruudukonKorkeus: Int
    
    init(aloittaja: Vuoro) {
        self.vuoro = aloittaja
        ruudukonKorkeus = 5
        ruudukonLeveys = 5
        voittoonTarvittavaSarja = 4
        alustaPelitilanne()
    }
    
    init(aloittaja: Vuoro, korkeus: Int, leveys: Int, voitto: Int) {
        vuoro = aloittaja
        ruudukonKorkeus = korkeus
        ruudukonLeveys = leveys
        voittoonTarvittavaSarja = voitto
        alustaPelitilanne()
    }
    
    private func alustaPelitilanne(){
        // lisätään kaikkiin ruutuihin tyhjä pelitilanne
        for _ in 1...ruudukonLeveys {
            for _ in 1...ruudukonKorkeus {
                tilanne.append(.tyhjä)
            }
        }
    }
    
    func pelaaVuoro(ruudunNumero: Int) -> Bool {
        viimeisinSiirto = ruudunNumero
        if !validiSiirto() { return false }
        if vuoro == .nolla {
            tilanne[ruudunNumero - 1] = .nolla
        } else {
            tilanne[ruudunNumero - 1] = .risti
        }
        tarkistaVoitto()
        return true
    }
    
   func vaihdaVuoro(){
        if vuoro == .nolla {
            vuoro = .risti
        } else {
            vuoro = .nolla
        }
    }
    
    private func validiSiirto() -> Bool {
        // vältetään virhetilanne
        if viimeisinSiirto > tilanne.count {
            print("Ruutu \(viimeisinSiirto) on suurempi kuin ruutujen määrä \(tilanne.count) + 1")
            return false
        }
        
        // tarkistetaan, että peli on kesken
        if voittaja != .tyhjä {
            print("peli on jo päättynyt, voittaja oli \(voittaja)")
            return false
        }
        
        // tarkistetaan, että ruutu on vapaa
        let indeksi = viimeisinSiirto - 1
        let ruutu = tilanne[indeksi]
        if ruutu != .tyhjä {
            print("Ruutu \(viimeisinSiirto) ei ole vapaa. Siinä on jo \(ruutu)")
            return false
        }
        
        return true
    }
    
    func tarkistaVoitto(){
        voittoVino()
        voittoPysty()
        voittoVaaka()
    }
    
    private func voittoPysty(){
        
        // päätellään sarakkeen ensimmäinen indeksi
        var indeksi = viimeisinSiirto % ruudukonLeveys - 1
        
        // jos indeksi on -1, silloin kyseessä on viides sarake
        if indeksi == -1 {
            indeksi = ruudukonLeveys - 1
        }
        
        // alustetaan muuttujat
        var sarjanPituus = 1
        var edellinenRuutu: RuudunTila = .tyhjä
        
        // käydään läpi kaikki sarakkeen ruudut
        while indeksi < tilanne.count {
            let ruutu = tilanne[indeksi]
            
            // jos peräkkäiset ruudut ovat samat mutta eivät tyhjiä
            if ruutu == edellinenRuutu && ruutu != .tyhjä {
                sarjanPituus = sarjanPituus + 1
            }
            else {
                sarjanPituus = 1
            }
            
            // tallennetaan ruutu ja otetaan käsittelyyn seuraava
            edellinenRuutu = ruutu
            indeksi = indeksi + ruudukonLeveys
            
            // kolme samaa voittaa
            if sarjanPituus == voittoonTarvittavaSarja {
                voittaja = ruutu
                break
            }
        }
        
    }
    
    private func voittoVaaka(){
        
        var indeksi = 0
        
        // käydään läpi kaikki rivit
        rivit: while indeksi < tilanne.count {
            
            var sarjanPituus = 1
            var edellinenRuutu: RuudunTila = .tyhjä
            
            // käydään läpi rivin ruudut
            ruudut: for rivinIndeksi in 0 ..< ruudukonLeveys {
                let ruutu = tilanne[indeksi + rivinIndeksi]
                if ruutu == edellinenRuutu && ruutu != .tyhjä {
                    sarjanPituus = sarjanPituus + 1
                } else {
                    sarjanPituus = 1
                }
                
                edellinenRuutu = ruutu
                
                // tarkistetaan voitto
                if sarjanPituus == voittoonTarvittavaSarja {
                    voittaja = ruutu
                    break rivit
                }
            }
            
            indeksi = indeksi + ruudukonLeveys
        }
        
    }
    
    private func voittoVino(){
        // listataan mahdolliset voittokombinaatiot
        var yhdistelmät = [[Int]]()
        
        // laskevan suoran ylin ruutu on vasen yläkulma
        let laskevanSuoranYläpää = 0
        
        // nousevan suoran ylin ruutu on voittoon tarvittava suora - 1
        let nousevanSuoranYläpää = voittoonTarvittavaSarja - 1
        
        // käydään läpi koko ruudukko siten, että sarja mahtuu valitun ruudun perään
        let korkeus = ruudukonKorkeus - voittoonTarvittavaSarja + 1
        let leveys = ruudukonLeveys - voittoonTarvittavaSarja + 1
        var indeksi = 0
        
        for x in 0 ..< leveys {
            for y in 0 ..< korkeus {
                
                // luodaan laskeva suora
                var laskevaSuora = [Int]()
                
                // lisätään alkupiste
                indeksi = laskevanSuoranYläpää + x + y * ruudukonLeveys
                laskevaSuora.append(indeksi)
                
                // lisätään loput ruudut
                while laskevaSuora.count < voittoonTarvittavaSarja {
                    // seuraavan ruudun indeksi on (leveys + 1) suurempi
                    indeksi = indeksi + ruudukonLeveys + 1
                    laskevaSuora.append(indeksi)
                }
                
                 yhdistelmät.append(laskevaSuora)
                
                // luodaan nouseva suora
                var nousevaSuora = [Int]()
                
                // lisätään alkupiste
                indeksi = nousevanSuoranYläpää + x + y * ruudukonLeveys
                nousevaSuora.append(indeksi)
                
                // lisätään loput ruudut
                while nousevaSuora.count < voittoonTarvittavaSarja {
                    // seuraavan ruudun indeksi on (leveys - 1) suurempi
                    indeksi = indeksi + ruudukonLeveys - 1
                    nousevaSuora.append(indeksi)
                }
                
                yhdistelmät.append(nousevaSuora)
            }
        }
    
        // käydään läpi kaikki voittavat yhdistelmät
        kombot: for yhdistelmä in yhdistelmät {
            var sarjanPituus = 1
            var edellinenRuutu: RuudunTila = .tyhjä
            
            ruudut: for indeksi in yhdistelmä {
                let ruutu = tilanne[indeksi]
                
                if ruutu != .tyhjä && ruutu == edellinenRuutu {
                    sarjanPituus = sarjanPituus + 1
                } else {
                    sarjanPituus = 1
                }
                
                edellinenRuutu = ruutu
                
                if sarjanPituus == voittoonTarvittavaSarja {
                    voittaja = ruutu
                    break kombot
                }
            }
        }
        
    }
    
    func aloitaAlusta(){
        for indeksi in 0 ..< tilanne.count {
            tilanne[indeksi] = .tyhjä
        }
        voittaja = .tyhjä
        vuoro = .risti
        viimeisinSiirto = -1
    }
    
}

enum Vuoro {
    case risti
    case nolla
}

enum RuudunTila {
    case risti
    case nolla
    case tyhjä
}

enum Voittaja {
    case risti
    case nolla
    case eiSelvilla
}
