//
//  HTTPRequest.swift
//
//
//  Created by Thais Rodríguez on 19/1/23.
//

import Extensions
import Foundation

protocol HTTPRequest {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
}

extension HTTPRequest {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let urlRequest = endpoint.urlRequest else {
            throw APIError.invalidURL
        }

        do {
            printRequestedData(from: endpoint.urlRequest?.url?.absoluteString)

            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            printDataReceived(from: endpoint.urlRequest?.url?.absoluteString, data: data)

            guard let _ = response as? HTTPURLResponse else {
                throw APIError.noResponse
            }

            return try decode(data: data, url: endpoint.urlRequest?.url?.absoluteString)

        } catch {
            dump(error, name: "⛔️⛔️⛔️ Request response error")
            let apiError = error as? APIError ?? .other(error)
            throw apiError
        }
    }

    func getFromLocalFile<T: Decodable>(fileName: String, bundle: Bundle = .main) async throws -> T  {
        printRequestedData(from: fileName)

        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            throw APIError.invalidURL
        }

        guard let fileContent = FileManager.default.contents(atPath: path) else {
            throw APIError.decode
        }

        printDataReceived(from: fileName, data: fileContent)

        return try decode(data: fileContent, url: fileName)
    }

    private func decode<T: Decodable>(data: Data, url: String?) throws -> T {
        do {
            let decodedObject: T = try data.decodeDataTo()
            return decodedObject
        } catch let decodingError {
            dump(decodingError, name: "⛔️⛔️⛔️🔐 Error decoding object at \(url ?? "NO URL")")
           throw APIError.decode
        }
    }

    private func printRequestedData(from url: String?) {
        print("🕊🕊🕊 Requested data from:", url ?? "NO URL")
    }

    private func printDataReceived(from url: String?, data: Data) {
        print("🪵🪵🪵 Request \(url ?? "NO URL") response:\n\(data.prettyPrintedJSONString)")
    }
}
