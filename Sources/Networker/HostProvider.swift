//
//  HostProvider.swift
//

import Foundation

public protocol HostProvider {

	var url: URL { get }

	func endpoint(append path: String) -> Endpoint

}

extension HostProvider {

	var root: Endpoint { .root(url: url) }

	func endpoint(append path: String) -> Endpoint {
		path.isEmpty 
		? root
		: .path(endpoint: root, path: path)
	}

}
