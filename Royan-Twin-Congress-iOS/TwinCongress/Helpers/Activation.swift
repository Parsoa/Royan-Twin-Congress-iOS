//
//  Activation.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/25/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import Foundation

struct Activation {
    private static let key = "activation@31213sxzaker"
    
    static func isActivated() -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func checkAndActivate(code: String) -> Bool {
        if check(code: code) {
            activate()
            return true
        }
        return false
    }
    
    private static let keys: [String] = ["54blf5","0aq44f","8gsiiv","uqzint","qp45zi","3ih1z0","6ezayv","jrrnkm","pkglbi",
                                         "rw3cvg","7tnbzr","aed6ef","kxm85i","gz2omw","wlfft8","hf6dl1","rifetd","foqhli",
                                         "8etegb","opz5pm","TestAppTwinCongress2017"]
    
    static private func check(code: String) -> Bool {
        return keys.contains(code)
    }
    
    static private func activate() {
        UserDefaults.standard.set(true, forKey: key)
    }
    
}
