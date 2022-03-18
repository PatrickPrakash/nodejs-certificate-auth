# Generate script because certs expire in 1 year (365 days)

# generate server certificate
openssl req \
	-x509 \
	-newkey rsa:4096 \
	-keyout server/server_key.pem \
	-out server/server_cert.pem \
	-nodes \
	-days 365 \
	-subj "/CN=TestAuthority/O=Client\ Certificate\ Demo"

# generate server-signed (valid) certifcate
openssl req \
	-newkey rsa:4096 \
	-keyout client/jestina_key.pem \
	-out client/jestina_csr.pem \
	-nodes \
	-days 365 \
	-subj "/CN=Jestina"

# sign with server_cert.pem
openssl x509 \
	-req \
	-in client/jestina_csr.pem \
	-CA server/server_cert.pem \
	-CAkey server/server_key.pem \
	-out client/jestina_cert.pem \
	-set_serial 01 \
	-days 365

# generate self-signed (invalid) certifcate
openssl req \
	-newkey rsa:4096 \
	-keyout client/bob_key.pem \
	-out client/bob_csr.pem \
	-nodes \
	-days 365 \
	-subj "/CN=Bob"

# sign with bob_csr.pem
openssl x509 \
	-req \
	-in client/bob_csr.pem \
	-signkey client/bob_key.pem \
	-out client/bob_cert.pem \
	-days 365