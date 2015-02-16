/* 
 * Title: Puppet for test
 * Author: CHEN Johnson
 * Version: 1.0
*/

node default {
  file {
   "/tmp/first.dat" :
    mode => 0666,
    content => "hello, puppet\n";
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
