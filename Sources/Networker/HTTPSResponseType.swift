//
//  Created by Andrew Kuts on 2022-12-02.
//

public enum HTTPSResponseType: Equatable {

	case info
	case success
	case redirect
	case clientError
	case serverError
	case untrustedCertificate
	case timeOut
	case unowned(code: Int)

	public init(rawValue: Int) {

		switch rawValue {

		case 100..<200:
			self = .info

		case 200..<300:
			self = .success

		case 300..<400:
			self = .redirect

		case 400..<500:
			self = .clientError

		case 500..<600:
			self = .serverError

		case -999:
			self = .untrustedCertificate

		case -1001:
			self = .timeOut

		default:
			self = .unowned(code: rawValue)
		}
	}
}
