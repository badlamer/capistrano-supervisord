require 'erb'

namespace(:supervisord) do
  namespace(:setup) do
    desc 'upload configs'
    task :configure do
      on roles(:app), except: { no_release: true } do
        fetch(:supervisord_configure_files).each do |file|
          src_file = File.join(fetch(:supervisord_configure_source_path), file)
          dst_file = File.join(
            fetch(:supervisord_configure_path),
            fetch(:supervisord_configure_file_prefix) + file + fetch(:supervisord_configure_file_suffix)
          )

          tmp_file = File.join('/tmp', File.basename(file))
          if File.file?(src_file)
            upload!(src_file, tmp_file)
          else
            abort("configure: no such template found: #{src_file} or #{src_file}.erb")
          end
          execute :diff, "-u #{dst_file} #{tmp_file}", '||', :sudo, :mv, "-f #{tmp_file} #{dst_file}; rm -f #{tmp_file}"
        end
      end
    end
  end

  namespace :service do
    desc 'Start supervisord'
    task :start do
      on roles(:app), except: { no_release: true } do
        execute(:sudo, :service, "#{fetch(:supervisord_service_name)} start")
      end
    end

    desc 'Stop supervisord'
    task :stop do
      on roles(:app), except: { no_release: true } do
        execute(:sudo, :service, "#{fetch(:supervisord_service_name)} stop")
      end
    end

    desc 'Status supervisord'
    task :status do
      on roles(:app), except: { no_release: true } do
        execute(:sudo, :service, "#{fetch(:supervisord_service_name)} status")
      end
    end

    desc 'Restart supervisord'
    task :restart do
      on roles(:app), except: { no_release: true } do
        execute(:sudo, :service, fetch(:supervisord_service_name), :restart,
                '||', :sudo, :service, fetch(:supervisord_service_name), :start)
      end
    end

    desc 'Reload supervisord'
    task :reload do
      on roles(:app), except: { no_release: true } do
        execute(:sudo, :service, fetch(:supervisord_service_name), 'force-reload',
                '||', :sudo, :service, fetch(:supervisord_service_name), :start)
      end
    end
  end
end
