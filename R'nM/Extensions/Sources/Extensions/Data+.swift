//
//  Data+.swift
//
//
//  Created by Thais Rodríguez on 12/11/22.
//

import Foundation

public extension Data {
    private static let decoder = JSONDecoder()

    func decodeDataTo<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        Self.decoder.dateDecodingStrategy = dateDecodingStrategy
        Self.decoder.keyDecodingStrategy = keyDecodingStrategy
        return try Self.decoder.decode(T.self, from: self)
    }

    var prettyPrintedJSONString: NSString {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }

        return prettyPrintedString
    }
}
