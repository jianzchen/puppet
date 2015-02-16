/* 
 * Title: Puppet for test
 * Author: CHEN Johnson
 * Version: 1.0
*/
$foo = [ 'one', 'two', 'three' ]

node default {
  include apache
  file {
   "/tmp/first.dat" :
    mode => 0666,
    content => "${foo[0]}\n";
  }
  exec {
   "test interval" :
   command => "/bin/date >> /tmp/interval.log";
  }
  file {
   "/tmp/from_master.dat" :
    source => "puppet:///modules/test/master.dat";
  }
  # source is a link, copy the content
  file {
  "/tmp/from_master_link.dat" :
    content => template("test/link.dat");
  }
}

class apache {
  package {'httpd':
    before => File['/etc/httpd/conf/httpd.conf'],
  }
  service {'httpd':
    ensure => running,
    enable => true,
    require => Package['httpd'],
    before => File['/etc/httpd/conf/httpd.conf'],
  }
  file { '/etc/httpd/conf/httpd.conf':
    ensure => file,
    owner => 'httpd',
    group => 'httpd',
    mode => 0666,
    content => template('apache/httpd.conf.erb'),
  }
}

/*

# regular exp
 if $host =~ /^www(\d+)\./ {
      notify { "Welcome web server #$1": }
    }
 $packages = $operatingsystem ? {
       /(?i-mx:ubuntu|debian)/        => 'apache2',
       /(?i-mx:centos|fedora|redhat)/ => 'httpd',
     }

# hash indexing
$myhash = { key       => "some value",
                other_key => "some other value" }
    notice( $myhash[key] )
$main_site = { port        => { http  => 80,
                                    https => 443 },
                   vhost_name  => 'docs.puppetlabs.com',
                   server_name => { mirror0 => 'warbler.example.com',
                                    mirror1 => 'egret.example.com' }
                 }
    notice ( $main_site[port][https] )
*/
