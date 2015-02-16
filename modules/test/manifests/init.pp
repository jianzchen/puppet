class test {
  file { "/tmp/test_from_module.dat":
    content => "test from modules/test/manifests/init.pp\n",
  }
}
