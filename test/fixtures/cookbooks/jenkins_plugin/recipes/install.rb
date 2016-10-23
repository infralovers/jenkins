node.default['jenkins']['master']['jvm_options'] = '-Djenkins.install.runSetupWizard=false'

include_recipe 'jenkins_server_wrapper::default'

# Test basic plugin installation
jenkins_plugin 'greenballs'

# Test installing a specific version
jenkins_plugin 'disk-usage' do
  version '0.23'
end

# Test installing from a URL
jenkins_plugin 'copy-to-slave' do
  source 'http://mirror.xmission.com/jenkins/plugins/copy-to-slave/1.4.3/copy-to-slave.hpi'
end

# Install a plugin with many deps 
# depends on github-api 1.67 https://github.com/jenkinsci/github-oauth-plugin/blob/e804d0b7d454b066ba016561fe7a1ca3804771dd/pom.xml#L82
jenkins_plugin 'github-oauth' do
  version '0.21.1'
  install_deps true
  notifies :restart, 'service[jenkins]', :immediately
end
jenkins_plugin 'github-oauth' do
  install_deps true
end

# Skip this plugins deps
jenkins_plugin 'jquery-ui' do
  install_deps false
end

# Install with a wacky version number
jenkins_plugin 'build-monitor-plugin' do
  version '1.6+build.135'
  install_deps true
  notifies :restart, 'service[jenkins]', :immediately
end
