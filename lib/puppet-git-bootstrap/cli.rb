require 'trollop'
require 'puppet-git-bootstrap/bootstrapper'

module PuppetGitBootstrap

  class CLI

    def run
      opts = Trollop::options do
        banner "Usage: #{$0} [options] <user@host>"

        opt :os,       'The remote operating system',          type: :string
        opt :port,     'The ssh port to connect on',           type: :integer
        opt :identity, 'The private key to authenticate with', type: :string
        opt :list,     'List supported operating systems'
      end

      if opts[:list]
        puts 'Supported operating systems:'
        puts
        Dir.glob(File.dirname(__FILE__) + '/support/scripts/*').each do |os|
          puts "  #{File.basename(os, File.extname(os))}"
        end
        puts
        exit 0
      end

      begin
        Bootstrapper.new(ARGV.shift, opts).run
      rescue ArgumentError => e
        Trollop::die e
      end
    end

  end

end
