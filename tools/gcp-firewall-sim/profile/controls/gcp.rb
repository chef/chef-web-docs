gcp_project_id = input('gcp_project_id')

control 'gcp-02' do
  impact 'high'
  title 'Firewall rules must not allow unrestricted remote administration'
  desc 'SSH (22) and RDP (3389) open to 0.0.0.0/0 let anyone on the internet attempt a login.'
  tag 'gcp', 'compute'

  google_compute_firewalls(project: gcp_project_id).where(firewall_direction: 'INGRESS').firewall_names.each do |firewall_name|
    firewall = google_compute_firewall(project: gcp_project_id, name: firewall_name)
    next unless firewall.source_ranges.to_a.include?('0.0.0.0/0')

    describe firewall do
      it { should_not allow_port_protocol('22', 'tcp') }
      it { should_not allow_port_protocol('3389', 'tcp') }
    end
  end
end
