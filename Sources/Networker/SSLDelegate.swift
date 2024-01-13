//
//  Created by Andrew Kuts on 2022-12-05.
//

import Foundation

public protocol SSLPiningDelegate: URLSessionDelegate {
	init(isCertificateValid:  @escaping (SecTrust) -> Bool)
}

public final class SSLDelegate: NSObject, SSLPiningDelegate {

	let isCertificateValid: (SecTrust) -> Bool

	public init(isCertificateValid: @escaping (SecTrust) -> Bool) {
		self.isCertificateValid = isCertificateValid
	}

	public func urlSession(
		_ session: URLSession,
		didReceive challenge: URLAuthenticationChallenge,
		completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
	) {
		let protectionSpace = challenge.protectionSpace

		guard
			protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
			let serverTrust = protectionSpace.serverTrust
		else {
			completionHandler(.cancelAuthenticationChallenge, nil)
			return
		}

		if isCertificateValid(serverTrust) {
			completionHandler(.useCredential, URLCredential(trust: serverTrust))
		} else {
			completionHandler(.cancelAuthenticationChallenge, nil)
		}
	}
}
