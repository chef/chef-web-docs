class GoogleComputeFirewalls < Inspec.resource(1)
  name 'google_compute_firewalls'

  def initialize(params = {})
    @firewalls = GcpFirewallSimulation::FIREWALLS
  end

  def where(filters = {})
    @firewalls = @firewalls.select { |firewall| firewall[:direction] == filters[:firewall_direction] }
    self
  end

  def firewall_names
    @firewalls.map { |firewall| firewall[:name] }
  end
end

class GoogleComputeFirewall < Inspec.resource(1)
  name 'google_compute_firewall'

  def initialize(params = {})
    name = params[:name]
    @firewall = GcpFirewallSimulation::FIREWALLS.find { |firewall| firewall[:name] == name }
  end

  def source_ranges
    @firewall[:source_ranges]
  end

  def resource_id
    @firewall[:name]
  end

  def to_s
    "Firewall #{@firewall[:name]}"
  end

  def allow_port_protocol?(port, protocol)
    denied = @firewall[:denied]
    allowed_flag = denied.nil?
    property = allowed_flag ? @firewall[:allowed] : denied

    return allowed_flag if property.length == 1 && property[0][:protocol] == 'all'

    matching_rules = property.select { |rule| rule[:protocol] == protocol }
    matching_rules.each do |rule|
      (rule[:ports] || []).each do |rule_port|
        return allowed_flag if port_matches?(rule_port, port)
      end
    end

    !allowed_flag
  end

  RSpec::Matchers.alias_matcher :allow_port_protocol, :be_allow_port_protocol

  private

  def port_matches?(rule_port, port)
    return rule_port == port unless rule_port.include?('-')

    lower, upper = rule_port.split('-', 2).map(&:to_i)
    port.to_i.between?(lower, upper)
  end
end
