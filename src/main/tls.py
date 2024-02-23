import sys
import socket
import ssl

hostname = sys.argv[1]
context = ssl.create_default_context()

# Create a TCP connection to the server:
with socket.create_connection((hostname, 443)) as sock:
	# Negotiate TLS within that TCP connection:
	with context.wrap_socket(sock, server_hostname=hostname) as ssock:
		tls_version = ssock.version()
		tls_cipher = ssock.cipher()
		tls_certificate = ssock.getpeercert()
		print(f"TLS version: {tls_version}")
		print(f"TLS ciphers: {tls_cipher}")
		print(tls_certificate)
