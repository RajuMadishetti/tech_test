
#
# Cookbook Name:: devops_tech_exercise
# Recipe:: 
#
#

include_recipe "golang::default"


directory "/opt/gohome"


cookbook_file "/opt/gohome/test.go" do
  source "test.go"
  owner "root"
  group "root"
end

execute "/usr/local/go/bin/go build test.go" do
  cwd "/opt/gohome/"
  creates "/opt/gohome/test"
end

template "golang-test" do
  path "/etc/init.d/golang-test"
  source "golang.init.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[golang-test]"
  notifies :start, "service[golang-test]"
end

service "golang-test" do
  action [ :enable, :start ]
end


