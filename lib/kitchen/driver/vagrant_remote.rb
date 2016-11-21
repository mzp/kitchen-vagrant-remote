# frozen_string_literal: true
require "kitchen/driver/vagrant"
require "kitchen/driver/vagrant_remote_version"

module Kitchen
  module Driver
    class VagrantRemote < Kitchen::Driver::Vagrant
      include ShellOut
      kitchen_driver_api_version 2
      plugin_version Kitchen::Driver::VAGRANT_REMOTE_VERSION
    end
  end
end
