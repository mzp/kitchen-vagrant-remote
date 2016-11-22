# frozen_string_literal: true
require "kitchen/driver/vagrant"
require "kitchen/driver/vagrant_remote_version"
require "kitchen/driver/disable_gateway_option"

module Kitchen
  module Driver
    class VagrantRemote < Kitchen::Driver::Vagrant
      include ShellOut
      kitchen_driver_api_version 2
      plugin_version Kitchen::Driver::VAGRANT_REMOTE_VERSION

      default_config :remote_user, "user"
      default_config :remote_host, ""
      default_config :remote_root, "/private/tmp"
      default_config :remote_vagrant_binary, "vagrant"
      default_config :wrapper_script, "/tmp/wrapper"
      default_config :ssh_gateway, nil
      default_config :ssh_gateway_username, nil
      default_config :ssh_gateway_port, 22

      private

      def init_config(config)
        super

        File.write(@config[:wrapper_script], wrapper_code(@config))
        File.chmod(0766, @config[:wrapper_script])

        @config[:vagrant_binary] = @config[:wrapper_script]

        @config = LazyHash.new(@config, self)
      end

      def update_state(state)
        super

        copy_from_remote

        state[:ssh_key] = state[:ssh_key].sub(/\A#{config[:remote_root]}/, '')
        state[:ssh_gateway] = config[:remote_host]
        state[:ssh_gateway_username] = config[:remote_user]
        state[:ssh_gateway_port] = config[:ssh_gateway_port]
      end

      def run_vagrant_up
        info "run vagrant up at #{vagrant_root}"
        copy_to_remote
        super
      end

      def wrapper_code(config)
        <<-END
#!/bin/sh

cat <<CMD | ssh #{config[:remote_user]}@#{config[:remote_host]} bash --login
cd #{config[:remote_root]}
cd ./$(pwd)
#{config[:remote_vagrant_binary]} $@
CMD
        END
      end

      def copy_from_remote
        run("rsync -az #{config[:remote_user]}@#{config[:remote_host]}:#{remote_vagrant_root}/ #{vagrant_root}/")
      end

      def copy_to_remote
        run("ssh #{config[:remote_user]}@#{config[:remote_host]} mkdir -p #{remote_vagrant_root}")
        run("rsync -az #{vagrant_root}/ #{config[:remote_user]}@#{config[:remote_host]}:#{remote_vagrant_root}/")
      end

      def remote_vagrant_root
        "#{config[:remote_root]}/#{vagrant_root}"
      end
    end
  end
end
