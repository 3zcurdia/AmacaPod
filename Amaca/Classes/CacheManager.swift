//
//  CacheManager.swift
//  Amaca
//
//  Created by Luis Ezcurdia on 5/1/18.
//

import Foundation
import CCommonCrypto

protocol DirectoryManager {
    var manifest: [String: String] { get }
}

public class CacheManager<T>: DirectoryManager where T: Codable {
    private let storageType: StorageType = .cache
    public var manifest: [String: String] = [String: String]()

    public init() {
        storageType.ensureExists()
        self.loadManifest()
    }

    public func save(url: URL?, rawData: Data?, jsonData: T) -> String? {
        guard let url = url else { return nil }
        guard let data = rawData else { return nil }
        let filename = sha256(data: data)
        if filename != manifest[url.absoluteString] {
            deleteFile(filename)
            manifest[url.absoluteString] = filename
            saveManifest()
        }
        storeFor(filename: filename).save(jsonData)
        return filename
    }

    public func find(url: URL?) -> T? {
        guard let url = url else { return nil }
        guard let sha = manifest[url.absoluteString] else { return nil }
        return self.find(sha: sha)
    }

    private func find(sha filename: String) -> T? {
        return self.storeFor(filename: filename).storedValue
    }

    public func purge() {
        for (_, filename) in manifest { deleteFile(filename) }
        self.manifest = [String: String]()
        saveManifest()
    }

    private func storeFor(filename: String) -> LocalStore<T> {
        return LocalStore<T>(storageType: storageType, filename: filename)
    }

    private var manifestUrl: URL {
        return storageType.folder.appendingPathComponent("manifest-\(String(describing: T.self).lowercased)")
    }

    private func loadManifest() {
        guard let data = try? Data(contentsOf: manifestUrl) else { return }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                manifest = json
            }
        } catch let err {
            print("ERROR parsing mainfest: \(err)")
        }
    }

    private func saveManifest() {
        do {
            let data = try JSONEncoder().encode(manifest)
            try data.write(to: manifestUrl)
        } catch let e {
            print("ERROR writing manifest: \(e)")
        }
    }

    private func deleteFile(_ filename: String) {
        let fileUrl = storageType.folder.appendingPathComponent(filename)
        FileManager.default.fileExists(atPath: fileUrl.path)
    }

    private func sha256(data: Data) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
