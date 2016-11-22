# frozen_string_literal: true
require "kitchen/transport/ssh"

module DisableGatewayOption
  def establish_connection_via_gateway(opts)
    retry_connection(opts) do
      Net::SSH::Gateway
        .new(ssh_gateway, ssh_gateway_username, {})
        .ssh(hostname, username, options)
    end
  end
end

Kitchen::Transport::Ssh::Connection.prepend DisableGatewayOption
