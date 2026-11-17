# GCP firewall control simulation

This Docker profile runs the documented `gcp-02` control against local firewall
fixtures. It does not connect to Google Cloud, use GCP credentials, or validate
responses from the Google Cloud API.

The matcher behavior follows the `google_compute_firewall` resource in
`inspec-gcp` tag `v1.11.136`
([source](https://github.com/inspec/inspec-gcp/blob/e90ca69d2864f746155492c31fe7e15d8d1a09fd/libraries/google_compute_firewall.rb)).

To run the simulation from the repository root, build and run the image:

```shell
docker build --platform linux/amd64 -t gcp-firewall-sim:5.24.24 tools/gcp-firewall-sim
docker run --rm --platform linux/amd64 --env CHEF_LICENSE=accept gcp-firewall-sim:5.24.24
```

The fixture set covers IPv6 `::/0`, protocol `all`, SSH and RDP port ranges, a
disabled allow rule, a single-port deny rule, and a deny-all rule.

The simulated control selects only ingress rules with `0.0.0.0/0`.
It reports the following results:

| Fixture | `gcp-02` result |
| --- | --- |
| IPv6 `::/0`, allow all | Not selected; no assertions run |
| IPv4 `0.0.0.0/0`, allow all | Fails the SSH and RDP checks |
| TCP ranges `20-30` and `3388-3390` | Fails the SSH and RDP checks |
| Disabled IPv4 SSH allow | Fails the SSH check even though the rule is disabled |
| IPv4 deny SSH only | Passes the SSH check but fails the RDP check |
| IPv4 deny all | Passes both checks |

These are results from a local simulation, not evidence from a live GCP project.
The simulation does not verify how Google Cloud returns firewall rules or how
the resource pack interprets real API responses.
