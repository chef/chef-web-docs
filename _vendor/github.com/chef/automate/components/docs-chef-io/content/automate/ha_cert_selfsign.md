+++
title = "Self Sign Certificates"

draft = false

gh_repo = "automate"

[menu]
  [menu.automate]
    title = "Self Sign Certificates"
    parent = "automate/deploy_high_availability/certificates"
    identifier = "automate/deploy_high_availability/certificates/ha_cert_selfsign.md Self Sign Certificates"
    weight = 220
+++

{{< note >}}
{{% automate/ha-warn %}}
{{< /note >}}

## What are Certificates?

A security certificate is a small data file used as an Internet security technique through which the identity, authenticity, and reliability of a website or web application are established.

To ensure optimal security, rotate the certificates periodically.

## What are Self Signed Certificates?

A self-signed certificate is a digital certificate not signed by a publicly trusted certificate authority (CA). They are created, issued, and signed by the company or developer responsible for the website or software. The third party in such certificates does not validate the private keys. It is used in low-risk internal networks or the software development phase. So, you cannot revoke the CA-issues and the self-signed certificates.

## Certificate Creation

You can create a self-signed key and certificate pair with the **OpenSSL** utility, a command-line tool for creating and managing OpenSSL certificates, keys, and other files.

### Prerequisites

- Install an OpenSSL utility.

### Creating a Certificate

1. Navigate to your bastion host, and make a new directory. For example, `mkdir rotate-certs` (directory name can be anything).

1. `cd rotate-certs` then execute the below script.

    ```bash
      # Run with OpenSSL version 1.0.2k-fips    
      cat <<EOF >> root-ca.cnf
      [req]
      distinguished_name = req_distinguished_name
      x509_extensions = v3_ca
      prompt = no
      
      [req_distinguished_name]
      C = US
      ST = Washington
      L = Seattle
      O = Chef Software Inc
      CN = progress
      
      [v3_ca]
      basicConstraints = critical,CA:TRUE
      keyUsage = critical, keyCertSign, cRLSign
      EOF
      
      # Create certificate extension configuration files
      echo "extendedKeyUsage = clientAuth, serverAuth" > server_cert_ext.cnf
      echo "subjectAltName = DNS:chefadmin" >> server_cert_ext.cnf
      
      echo "extendedKeyUsage = clientAuth, serverAuth" > node_cert_ext.cnf
      echo "subjectAltName = DNS:chefnode" >> node_cert_ext.cnf
      
      echo "extendedKeyUsage = clientAuth, serverAuth" > client_cert_ext.cnf
      echo "subjectAltName = DNS:chefclient" >> client_cert_ext.cnf
      
      # Generate Root CA Key & Certificate
      openssl genrsa -out root-ca-key.pem 2048
      openssl req -new -x509 -sha256 -key root-ca-key.pem -out root-ca.pem -days 1095 -config root-ca.cnf
      
      # Admin Certificate
      openssl genrsa -out admin-key-temp.pem 2048
      openssl pkcs8 -inform PEM -outform PEM -in admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin-key.pem
      openssl req -new -key admin-key.pem -subj "/C=US/ST=Washington/L=Seattle/O=Chef Software Inc/CN=chefadmin" -out admin.csr
      openssl x509 -req -in admin.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out admin.pem -days 1095 -extfile server_cert_ext.cnf
      
      # Node Certificate 1
      openssl genrsa -out node1-key-temp.pem 2048
      openssl pkcs8 -inform PEM -outform PEM -in node1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node1-key.pem
      openssl req -new -key node1-key.pem -subj "/C=US/ST=Washington/L=Seattle/O=Chef Software Inc/CN=chefnode" -out node1.csr
      openssl x509 -req -in node1.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out node1.pem -days 1095 -extfile node_cert_ext.cnf
      
      # Node Certificate 2
      openssl genrsa -out node2-key-temp.pem 2048
      openssl pkcs8 -inform PEM -outform PEM -in node2-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node2-key.pem
      openssl req -new -key node2-key.pem -subj "/C=US/ST=Washington/L=Seattle/O=Chef Software Inc/CN=chefnode" -out node2.csr
      openssl x509 -req -in node2.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out node2.pem -days 1095 -extfile node_cert_ext.cnf
      
      # Node Certificate 3
      openssl genrsa -out node3-key-temp.pem 2048
      openssl pkcs8 -inform PEM -outform PEM -in node3-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node3-key.pem
      openssl req -new -key node3-key.pem -subj "/C=US/ST=Washington/L=Seattle/O=Chef Software Inc/CN=chefnode" -out node3.csr
      openssl x509 -req -in node3.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out node3.pem -days 1095 -extfile node_cert_ext.cnf
      
      # Client Certificate
      openssl genrsa -out client-key-temp.pem 2048
      openssl pkcs8 -inform PEM -outform PEM -in client-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out client-key.pem
      openssl req -new -key client-key.pem -subj "/C=US/ST=Washington/L=Seattle/O=Chef Software Inc/CN=chefclient" -out client.csr
      openssl x509 -req -in client.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out client.pem -days 1095 -extfile client_cert_ext.cnf

    ```

1. The script generates the certificates at the newly created directory, `rotate-certs` in this case.

{{< note >}}

- To create self-signed certificate for FQDN make sure to provide proper DNS and CN value. The DNS in Subject Alternative Name should match with the CN (Common Name).
- CN (Common Name) should be the same for all certificates in Opensearch nodes.

{{< /note >}}

{{< note >}}

Please refer OpenSearch certificate [documentation](https://opensearch.org/docs/1.2/security-plugin/configuration/tls/#x509-pem-certificates-and-pkcs-8-keys)

{{< /note >}}