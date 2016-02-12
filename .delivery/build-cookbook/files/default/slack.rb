begin
  require "slack-notifier"
rescue LoadError
  Chef::Log.debug("Chef slack_handler requires `slack-notifier` gem")
end

require "timeout"

module BuildCookbook
  class SlackHandler < Chef::Handler
    attr_accessor :webhook_url, :channels, :username, :icon_emoj

    def initialize(options = {})
      @webhook_url = options[:webhook_url]
      @username = options[:username] || 'delivery'
      @channels = options[:channels] || '#delivery'
      @icon_emoj = options[:icon_emoj] || ":chef:"
    end

    def report
      msg = "*[#{node['delivery']['change']['project']}] (#{node['delivery']['change']['stage']}:#{node['delivery']['change']['phase']})* Change Failed: #{make_link(change_url)}"
      Chef::Log.debug("Sending report to Slack @chefio.slack.com")
      Chef::Log.error msg
      slack_message(msg)
    end

    def slack_message(content)
      slack = Slack::Notifier.new(@webhook_url)
      @channels.each do |channel|
        config = {}
        config['channel'] = channel
        config['username'] = @username
        slack.ping(content,config)
      end
    end

  end
end
