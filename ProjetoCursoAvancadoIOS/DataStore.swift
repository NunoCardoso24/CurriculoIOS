//
//  DataStore.swift
//  ProjetoCursoAvancadoIOS
//
//  Created by Nuno Cardoso on 25/11/14.
//  Copyright (c) 2014 Nuno Cardoso. All rights reserved.
//

import Foundation

class DataStore {
    class var current:DataStore{
        struct Singleton {
            static var instance: DataStore?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Singleton.token) {
            Singleton.instance = DataStore()
        }
        return Singleton.instance!
    }
    

    
}
