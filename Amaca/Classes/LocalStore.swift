//
//  LocalStore.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 5/1/18.
//

import Foundation

public class LocalStore<T> where T: Codable {
    let storageType: StorageType
    public let filename: String
    public var encoder: JSONEncoder = JSONEncoder()
    public var decoder: JSONDecoder = JSONDecoder()

    public init(storageType: StorageType, filename: String) {
        self.storageType = storageType
        self.filename = filename
        self.storageType.ensureExists()
    }

    public func save(_ object: T) {
        do {
            let data = try encoder.encode(object)
            try data.write(to: fileURL)
        } catch let err {
            print("ERROR: \(err)")
        }
    }

    public func delete() {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(at: fileURL)
        }
    }

    public var storedValue: T? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return try decoder.decode(T.self, from: data)
        } catch let err {
            print("ERROR: \(err)")
            return nil
        }
    }

    private var fileURL: URL {
        return storageType.folder.appendingPathComponent(filename)
    }
}
