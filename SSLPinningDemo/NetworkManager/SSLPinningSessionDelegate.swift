//
//  SSLPinningSessionDelegate.swift
//  SSLPinningDemo
//
//  Created by Nikunj Damani on 22/01/26.
//

import Security
import Foundation

class SSLPinningSessionDelegate: NSObject, URLSessionDelegate {
    private lazy var pinnedCertData: Data? = {
        guard let url = Bundle.main.url(forResource: "badssl", withExtension: "der") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }()
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
        let serverTrust = challenge.protectionSpace.serverTrust,
        let pinnedCertData = pinnedCertData
        else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        guard let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        for certificate in certificateChain {
            let serverCertificateData = SecCertificateCopyData(certificate)
            
            guard let data = CFDataGetBytePtr(serverCertificateData) else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }
            
            let size = CFDataGetLength(serverCertificateData)
            let serverCertData = Data(bytes: data, count: size)
            
            if serverCertData == pinnedCertData {
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
                return
            }
        }
        
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
