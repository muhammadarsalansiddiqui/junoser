require 'test-unit'
require 'junoser'

class TestSetSyntax < Test::Unit::TestCase

  data('log-out-on-disconnect' => 'set system ports console log-out-on-disconnect',
       'static inet6 route' => 'set routing-options rib inet6.0 static route ::/0 preference 250',
       'static inet route' => 'set routing-options static route 0.0.0.0/0 preference 250',
       'bfd traceoptions' => 'set protocols bfd traceoptions file xxxx',
       'ssh no-passwords' => 'set system services ssh no-passwords')

  test 'valid syntax' do |data|
    config = data
    assert_true Junoser::Cli.commit_check(config)
  end

  data('ospf area export' => 'set protocols ospf area 0.0.0.0 export opsf-export')

  test 'invalid syntax' do |data|
    config = data
    assert_false Junoser::Cli.commit_check(config)
  end
end
