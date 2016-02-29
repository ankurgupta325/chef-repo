#
# Cookbook Name:: docker-dev
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Pull latest image
docker_image 'nginx' do
  tag 'latest'
  action :pull
  notifies :redeploy, 'docker_container[my_nginx]'
end

# Run container exposing ports
docker_container 'my_nginx' do
  repo 'nginx'
  tag 'latest'
  port '80:80'
  host_name 'ankugup-docker-dev'
  domain_name 'corp.adobe.com'
  env 'dev=dev'
  volumes [ '/apps/docker/shared:/etc/nginx/conf.d' ]
end
