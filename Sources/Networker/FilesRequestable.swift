//
//  Created by Andrew Kuts on 2024-01-13.
//

import Foundation

public protocol FilesRequestable: Requestable {
	var files: [String: FileProtocol] { get }
}

public protocol FileProtocol {
	var data: Data { get }
	var filename: String { get }
	var mimeType: String? { get }
}
