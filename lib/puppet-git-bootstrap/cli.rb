require 'trollop'
require 'puppet-git-bootstrap/bootstrapper'

module PuppetGitBootstrap

  class CLI

    def run
      opts = Trollop::options do
        banner "Usage: #{$0} [options] <user@host>"

        opt :os,       'The remote operating system',          type: :string,  short: :o
        opt :port,     'The ssh port to connect on',           type: :integer, short: :p
        opt :identity, 'The private key to authenticate with', type: :string,  short: :i
        opt :nopuppet, 'Do not bootstrap puppet',              type: :flag,    short: :u
        opt :nogit,    'Do not bootstrap git',                 type: :flag,    short: :g
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
