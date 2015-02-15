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
  file {
  "/tmp/from_master_link.dat" :
    content => template("test/link.dat");
  }
}
