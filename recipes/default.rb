#
# Cookbook Name:: docker-demo
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

passwd = data_bag_item("creds", "hub")

# apt update
execute 'apt-get update' do
  command 'apt-get update'
  action :run
end

# Install Docker
docker_service 'default' do
	action [:create, :start]
end

# Pull an image
docker_image 'redis' do
	action :pull
end

# Run a container
docker_container 'my_redis' do
	action :run
	repo 'redis'
	port '6379:6379'
end

# # Create an image
# directory '/tmp/vizceral' do
#   mode '0755'
#   action :create
#   recursive true
# end


# git '/tmp/vizceral' do
#   repository 'git://github.com/Netflix/vizceral-example.git'
#   reference 'master'
#   action :sync
# end

# docker_image 'atul86244/vizceral' do
# 	action :build_if_missing
# 	tag '1.0'
# 	source '/tmp/vizceral/Dockerfile'
# end

# docker_registry 'https://index.docker.io/v1/' do
# 	username 'atul86244'
# 	email 'atul@chef.io'
# 	password passwd['hub_passwd']
# end

# # Push image
# docker_image 'atul86244/vizceral:1.0' do
# 	action :push
# end


docker_image 'atul86244/vizceral' do
	action :pull
	tag '1.0'
end


# Run container
docker_container 'vizceral' do
	repo 'atul86244/vizceral'
	tag '1.0'
	port '80:8080'
	action :run
end

