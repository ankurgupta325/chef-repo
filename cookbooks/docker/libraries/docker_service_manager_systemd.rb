module DockerCookbook
  class DockerServiceManagerSystemd < DockerServiceBase
<<<<<<< HEAD
    resource_name :docker_service_manager_systemd
=======
    use_automatic_resource_name
>>>>>>> chef-vendor-docker

    provides :docker_service_manager, platform: 'fedora'

    provides :docker_service_manager, platform: %w(redhat centos scientific) do |node| # ~FC005
      node['platform_version'].to_f >= 7.0
    end

    provides :docker_service_manager, platform: 'debian' do |node|
      node['platform_version'].to_f >= 8.0
    end

    provides :docker_service_manager, platform: 'ubuntu' do |node|
      node['platform_version'].to_f >= 15.04
    end

<<<<<<< HEAD
    property :service_timeout, Integer, default: 20

    def libexec_dir
      return '/usr/libexec/docker' if node['platform_family'] == 'rhel'
      '/usr/lib/docker'
    end

    action :start do
      directory libexec_dir do
=======
    action :start do
      # Needed for Debian / Ubuntu
      directory '/usr/libexec' do
>>>>>>> chef-vendor-docker
        owner 'root'
        group 'root'
        mode '0755'
        action :create
      end

      # this script is called by the main systemd unit file, and
      # spins around until the service is actually up and running.
<<<<<<< HEAD
      template "#{libexec_dir}/#{docker_name}-wait-ready" do
=======
      template "/usr/libexec/#{docker_name}-wait-ready" do
>>>>>>> chef-vendor-docker
        source 'systemd/docker-wait-ready.erb'
        owner 'root'
        group 'root'
        mode '0755'
<<<<<<< HEAD
        variables(
          docker_cmd: docker_cmd,
          libexec_dir: libexec_dir,
          service_timeout: service_timeout
        )
=======
        variables(docker_cmd: docker_cmd)
>>>>>>> chef-vendor-docker
        cookbook 'docker'
        action :create
      end

<<<<<<< HEAD
      # stock systemd unit file
=======
      # this is the main systemd unit file
>>>>>>> chef-vendor-docker
      template "/lib/systemd/system/#{docker_name}.service" do
        source 'systemd/docker.service.erb'
        owner 'root'
        group 'root'
        mode '0644'
<<<<<<< HEAD
        variables(docker_name: docker_name)
        cookbook 'docker'
        action :create
        not_if { docker_name == 'default' && ::File.exist?('/lib/systemd/system/docker.service') }
      end

      # stock systemd socket file
      template "/lib/systemd/system/#{docker_name}.socket" do
        source 'systemd/docker.socket.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(docker_name: docker_name)
        cookbook 'docker'
        action :create
        not_if { docker_name == 'default' && ::File.exist?('/lib/systemd/system/docker.socket') }
      end

      # this overrides the main systemd unit file
      template "/etc/systemd/system/#{docker_name}.service" do
        source 'systemd/docker.service-override.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
          config: new_resource,
          docker_daemon_cmd: docker_daemon_cmd,
          docker_name: docker_name,
          libexec_dir: libexec_dir
        )
        cookbook 'docker'
        notifies :run, 'execute[systemctl daemon-reload]', :immediately
        notifies :restart, new_resource
        action :create
      end

      # this overrides the main systemd socket
      template "/etc/systemd/system/#{docker_name}.socket" do
        source 'systemd/docker.socket-override.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
          config: new_resource,
          docker_name: docker_name
        )
        cookbook 'docker'
        notifies :run, 'execute[systemctl daemon-reload]', :immediately
        notifies :restart, new_resource
=======
        variables(
          config: new_resource,
          docker_name: docker_name,
          docker_daemon_cmd: docker_daemon_cmd
        )
        cookbook 'docker'
        notifies :run, 'execute[systemctl daemon-reload]', :immediately
        notifies :restart, new_resource unless ::File.exist? "/etc/#{docker_name}-firstconverge"
        notifies :restart, new_resource if auto_restart
        action :create
      end

      file "/etc/#{docker_name}-firstconverge" do
>>>>>>> chef-vendor-docker
        action :create
      end

      # avoid 'Unit file changed on disk' warning
      execute 'systemctl daemon-reload' do
        command '/bin/systemctl daemon-reload'
        action :nothing
      end

<<<<<<< HEAD
=======
      # tmpfiles.d config so the service survives reboot
      template "/usr/lib/tmpfiles.d/#{docker_name}.conf" do
        source 'systemd/tmpfiles.d.conf.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(config: new_resource)
        cookbook 'docker'
        action :create
      end

>>>>>>> chef-vendor-docker
      # service management resource
      service docker_name do
        provider Chef::Provider::Service::Systemd
        supports status: true
        action [:enable, :start]
        only_if { ::File.exist?("/lib/systemd/system/#{docker_name}.service") }
      end
    end

    action :stop do
      # service management resource
      service docker_name do
        provider Chef::Provider::Service::Systemd
        supports status: true
        action [:disable, :stop]
        only_if { ::File.exist?("/lib/systemd/system/#{docker_name}.service") }
      end
    end

    action :restart do
      action_stop
      action_start
    end
  end
end
