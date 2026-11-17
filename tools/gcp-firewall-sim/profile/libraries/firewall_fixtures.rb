module GcpFirewallSimulation
  FIREWALLS = [
    {
      name: 'ipv6-all',
      direction: 'INGRESS',
      source_ranges: ['::/0'],
      allowed: [{ protocol: 'all', ports: nil }],
    },
    {
      name: 'ipv4-all',
      direction: 'INGRESS',
      source_ranges: ['0.0.0.0/0'],
      allowed: [{ protocol: 'all', ports: nil }],
    },
    {
      name: 'tcp-port-ranges',
      direction: 'INGRESS',
      source_ranges: ['0.0.0.0/0'],
      allowed: [
        { protocol: 'tcp', ports: ['20-30'] },
        { protocol: 'tcp', ports: ['3388-3390'] },
      ],
    },
    {
      name: 'disabled-ssh',
      direction: 'INGRESS',
      source_ranges: ['0.0.0.0/0'],
      disabled: true,
      allowed: [{ protocol: 'tcp', ports: ['22'] }],
    },
    {
      name: 'deny-ssh',
      direction: 'INGRESS',
      source_ranges: ['0.0.0.0/0'],
      denied: [{ protocol: 'tcp', ports: ['22'] }],
    },
    {
      name: 'deny-all',
      direction: 'INGRESS',
      source_ranges: ['0.0.0.0/0'],
      denied: [{ protocol: 'all', ports: nil }],
    },
  ].freeze
end
