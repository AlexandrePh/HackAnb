//
//  Models.swift
//  HackAnbi
//
//  Created by Alexandre Philippi on 01/09/19.
//  Copyright © 2019 free. All rights reserved.
//

import Foundation

struct Tempo:Hashable{
    
    
    var dia:Int
    var mes:Int
    var ano:Int
    static func == (lhs: Tempo, rhs: Tempo) -> Bool {
        return lhs.dia == rhs.dia && lhs.mes == rhs.mes && lhs.ano == rhs.ano
    }
   
}

struct CompiladoSuitability{
    var tempo:Tempo
    var arrojadoVolCotas:Int
    var moderadoVolCotas:Int
    var conservadorVolCotas:Int
    
    var arrojadoNI:Int?
    var moderadoNI:Int?
    var conservadorNI:Int?
    
    
}




