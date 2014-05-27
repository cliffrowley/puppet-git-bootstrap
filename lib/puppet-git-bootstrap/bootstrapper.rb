require 'sshkit'
require 'sshkit/dsl'

module PuppetGitBootstrap

  class Bootstrapper

    attr_accessor :host
    attr_accessor :opts

    def initialize(host, opts = {})
      @host = host
      @opts = opts
    end

    def run
      raise ArgumentError.new('No host specified') unless host
      raise ArgumentError.new('No os specified')   unless opts[:os]

      unless File.exists?(script_path)
        raise ArgumentError.new("OS '#{opts[:os]}' not supported")
      end

      local_path = script_path
      ssh_opts   = {}

      ssh_opts[:port] = opts[:port] if opts[:port]

      if opts[:identity]
        ssh_opts[:keys]      = opts[:identity]
        ssh_opts[:keys_only] = true
      end

      on host do |host|
        host.ssh_options = ssh_opts
        upload! local_path, '/tmp/puppet-bootstrap.sh'
        execute 'sudo sh /tmp/puppet-bootstrap.sh'
        # TODO set up git and its hook
      end
    end

    private

    def scripts_dir
      File.expand_path(File.dirname(__FILE__) + '/support/scripts')
    end

    def script_path
      "#{scripts_dir}/#{opts[:os]}.sh"
    end

  end

end
