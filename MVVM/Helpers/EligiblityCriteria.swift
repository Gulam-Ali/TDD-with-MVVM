//
//  EligiblityCriteria.swift
//  MVVM
//
//  Created by Gulam Ali on 05/04/22.
//

import Foundation

protocol EligibilityCriteriaProtocol{
    func checkIfUserIseligibletoBookTicket() -> Bool
}


class EligibilityCriteria : EligibilityCriteriaProtocol {
    
    
    func checkIfUserIseligibletoBookTicket() -> Bool{
        /*
         here can be logics
         1.checking user logged in or not
         2.get user token
         3.check ticket status - Available or sold out
         */
        return true
    }
    
}
