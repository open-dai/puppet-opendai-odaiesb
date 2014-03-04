# Class: odaiesb
#
# This module manages odaiesb
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class odaiesb($repo_server) {
  $esb      = hiera('esb', undef)
  $greg      = hiera('greg', undef)
  
  package { 'unzip': ensure => present, }

  package { 'mysql': ensure => present, }

  # REQUIREMENTS
  # Java
  class { 'opendai_java':
    distribution => 'jdk',
    version      => '6u25',
    repos        => $repo_server, 
  }

  class { 'wso2esb':
    download_site => "http://${repo_server}/",
    db_type=>$esb["db_type"],
    db_host=>$esb["db_host"],
    db_name=>$esb["db_name"],
    db_user=>$esb["db_user"],
    db_password=>$esb["db_password"],
    db_tag=>$esb["db_tag"],
    version =>"2.2.0",
    admin_password=>$esb["admin_password"],
    external_greg   => "true",
    greg_server_url   => $greg["server_url"],
    greg_db_host   => $greg["db_host"],
  greg_db_name        => $greg["db_name"],
  greg_db_type   => $greg["db_type"],
  greg_username   => $greg["db_name"],
  greg_password   => $greg["db_password"],    
    require       => [Class['opendai_java'], Package['unzip'], Package['mysql']]
  }
  
}
