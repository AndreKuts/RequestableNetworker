//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation

public protocol Requestable {
	var method: HttpMethod { get }
	var endpoint: Endpoint { get }
	var headers: Headers? { get }
	var encoder: ParametersEncoder { get }
	var urlRequest: URLRequest { get }
}

public protocol HeadersContainable {
	var headers: Headers { get }
}

public protocol BodyRequestable: Requestable {
	var body: Data { get }
}

public protocol ParametersRequestable: Requestable {
	var parameters: Parameters { get }
}

public protocol FilesRequestable: Requestable {
	var files: [String: FileProtocol] { get }
}

public typealias Headers = [String : String]
public typealias Parameters = [String : Any]

public enum HttpMethod: String {

	case get
	case post
	case put
	case patch
	case delete

	var name: String {
		switch self {
		case .get:
			return "GET"
		case .post:
			return "POST"
		case .put:
			return "PUT"
		case .patch:
			return "PATCH"
		case .delete:
			return "DELETE"
		}
	}
}

public indirect enum Endpoint {

	case root(url: URL)
	case path(endpoint: Endpoint, path: String)

	public var url: URL {
		switch self {
		case .root(let url):
			return url
		case .path(let endpoint, let path):
			return endpoint.url.appendingPathComponent(path)
		}
	}
}

public protocol ParametersEncoder {
	var headers: Headers? { get }
	func encode<T: Requestable>(_ requestable: T) -> URLRequest
}

public protocol FileProtocol {
	var data: Data { get }
	var filename: String { get }
	var mimeType: String? { get }
}
