set(:supervisord_configure_path, '/')
set(:supervisord_configure_source_path, File.join(File.dirname(__FILE__), 'templates', 'supervisord'))
set(:supervisord_configure_files, [])
set(:supervisord_configure_file_prefix, '')
set(:supervisord_configure_file_suffix, '')
set(:supervisord_configure_cleanup_files, [])

set(:supervisord_install_method, :apt)
set(:supervisord_service_method, :sysvinit)

set(:supervisord_service_name, 'supervisor')
