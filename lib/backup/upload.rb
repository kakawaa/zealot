require 'yaml'

module Backup
  class Upload
    include Backup::Manager::Config

    def dump
      prepare
      puts "Dumping uploaded apps #{app_store_path} ..."
      Dir.glob("#{app_store_path}/*").each do |app_path|
        Dir.glob("#{app_path}/*").each do |release_path|
          relative_path = release_path.clone
          relative_path = release_path.slice!(app_store_path)
          backup_path = File.join(app_backup_path, relative_path)

          print " * #{relative_path} ..."

          FileUtils.mkdir_p(backup_path)
          FileUtils.cp_r(release_path, backup_path)
          print ' [DONE]'
          puts ''
        end
      end
    end

    protected

    def prepare
      FileUtils.rm_rf(app_backup_path)
      # Fail if somebody raced to create backup_repos_path before us
      FileUtils.mkdir_p(app_backup_path, mode: 0700)
    end
  end
end