virt_pip { '/opt/venv:Pygments':
  ensure       => present,
  version      => '1.4',
  install_opts => ['--no-deps'],
}
