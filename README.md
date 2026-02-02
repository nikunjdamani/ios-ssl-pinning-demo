# iOS SSL Pinning Demo

A production-style SSL pinning implementation in iOS using URLSession,
with SwiftUI as the UI layer and async/await.

## Why SwiftUI?
SwiftUI is used only as the presentation layer.
The SSL pinning implementation is UI-agnostic and can be reused in UIKit
or SDK-based projects.

## How to obtain .der file?
You can obtain der file using following command.
```openssl s_client -connect badssl.com:443 -servername badssl.com < /dev/null | openssl x509 -outform DER > certificate.der```

## Contact
For questions or discussions, connect with me on 
LinkedIn:
https://www.linkedin.com/in/nikunjkdamani/
X:
https://x.com/nikunjkdamani

