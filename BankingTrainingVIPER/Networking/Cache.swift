//
//  Cache.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import Foundation

protocol ResponseCacheProtcol {
    func get(forKey key: String)  -> Data?
    func set(item : ResponseCacheEntry , forKey : String)
    func remove(itemAtKey key : String)
}

final class ResponseCacheEntry {
    let value: Data
    let expirationDate: Date
    init(value: Data, expirationDate: Date  = Date().addingTimeInterval(2*60)) {
        self.value = value
        self.expirationDate = expirationDate
    }
}

final class ResponseCache : ResponseCacheProtcol {
    
    private var cache =  NSCache<NSString,ResponseCacheEntry>()
    
    func get<T>(forKey key: String) -> T? where T : Decodable {
        if let data = self.get(forKey: key) , let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        return nil
    }
    
    func get(forKey key: String)-> Data?  {
        let keyString = key as NSString
        guard let entry = cache.object(forKey: keyString) else {return nil}
        
        if entry.expirationDate < Date() {
            return entry.value
        }
        remove(itemAtKey: key)
        return nil
    }
    
    func set(item: ResponseCacheEntry, forKey: String) {
        cache.setObject(item, forKey: forKey as NSString )
    }
    
    func remove(itemAtKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
