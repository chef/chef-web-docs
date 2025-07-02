+++
title = "Rotate Habitat Builder's SSL certificates"

[menu.habitat]
  title = "Rotate SSL certs"
  identifier = "habitat/on-prem-builder/manage/SSL certs"
  parent = "habitat/on-prem-builder/manage"
  weight = 40
+++

Chef Habitat On-Prem Builder's web frontend runs on NGINX using the `habitat/builder-api-proxy` service.
The NGINX config for this service loads the SSL certificate and key from `/hab/svc/builder-api-proxy/files`.

## Rotate the SSL certificate and key

There's really a few simple commands to run in order to rotate your key.

1. Rename your SSL certificate and key file to the names required by the builder-api-proxy service:

    ```shell
    cp <CERTIFICATE_CHAIN_FILENAME> ssl-certificate.crt
    cp <CERTIFICATE_KEY_FILENAME> ssl-certificate.key
    ```

    The certificate and key files must be named `ssl-certificate.crt` and `ssl-certificate.key`.

1. Upload the certificate and key files to the builder service:

    ```shell
    hab file upload "builder-api-proxy.default" "$(date +%s)" ./ssl-certificate.crt
    hab file upload "builder-api-proxy.default" "$(date +%s)" ./ssl-certificate.key
    ```

1. Restart the builder-api-proxy service:

    ```shell
    hab svc stop habitat/builder-api-proxy && hab svc start habitat/builder-api-proxy
    ```

    This puts the updated files into the appropriate path and restarts NGINX so that it's using your new certificate and key.

You should now be able to verify through your browser or with the `openssl s_client -connect` command that Habitat Builder has an updated certificate.
