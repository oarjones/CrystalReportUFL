MD Certificate
CD Certificate

ECHO authorityKeyIdentifier=keyid,issuer>certificate.ext
ECHO basicConstraints=CA:FALSE>>certificate.ext
ECHO keyUsage=digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment>>certificate.ext
ECHO subjectAltName=@alt_names>>certificate.ext
ECHO.>>certificate.ext
ECHO [alt_names]>>certificate.ext
ECHO DNS.1=RS>>certificate.ext

openssl.exe genrsa -des3 -passout pass:"Am1lcarbarca" -out certificate.pass.key 2048
openssl.exe rsa -passin pass:"Am1lcarbarca" -in certificate.pass.key -out certificate.key
openssl.exe req -new -key certificate.key -out certificate.csr
openssl.exe x509 -req -sha256 -extfile certificate.ext -days 365 -in certificate.csr -signkey certificate.key -out certificate.crt
openssl.exe pkcs12 -export -out certificate.pfx -inkey certificate.key -in certificate.crt