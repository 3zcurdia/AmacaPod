//
//  LocalStoreCache.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 5/1/18.
//

import Foundation

public class LocalStoreCache<T>: LocalStore<T> where T: Codable {
    init(filename: String) {
        super.init(storageType: .cache, filename: filename)
    }
}
