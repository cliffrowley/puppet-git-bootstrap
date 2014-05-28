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

      ssh_opts = {}
      ssh_opts[:port] = opts[:port] if opts[:port]

      if opts[:identity]
        ssh_opts[:keys]      = opts[:identity]
        ssh_opts[:keys_only] = true
      end

      local_script_path  = script_path
      local_support_path = support_path
      local_opts         = opts

      on host do |host|
        host.ssh_options = ssh_opts

        unless local_opts[:nopuppet]
          upload! local_script_path, '/tmp/puppet-bootstrap.sh'
          execute 'sudo sh /tmp/puppet-bootstrap.sh'
        end

        unless local_opts[:nogit]
          upload! "#{local_support_path}/setup/git/git.pp", '/tmp/git.pp'
          execute 'sudo puppet apply /tmp/git.pp'
        end
      end
    end

    private

    def support_path
      File.expand_path(File.dirname(__FILE__) + '/support')
    end

    def scripts_dir
      "#{support_path}/setup/puppet"
    end

    def script_path
      "#{scripts_dir}/#{opts[:os]}.sh"
    end

  end

end
