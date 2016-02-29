#
# Cookbook Name:: docker-dev
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
docker_installation 'default' do
  repo 'test'
  action :create
end
