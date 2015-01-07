%w{mosh nano vim htop zip unzip ant subversion mc curl mod_ssl gawk}.each do |a_package|
  package a_package
end


service 'apache2' do
  service_name node['apache']['package']
  case node['platform_family']
  when 'rhel'
    reload_command '/sbin/service httpd restart'
  when 'debian'
    provider Chef::Provider::Service::Debian
  when 'arch'
    service_name 'httpd'
  end
  supports [:start, :restart, :reload, :status]
  action [:enable, :start]
  only_if "#{node['apache']['binary']} -t", :environment => { 'APACHE_LOG_DIR' => node['apache']['log_dir'] }, :timeout => 2
end