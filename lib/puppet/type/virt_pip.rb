Puppet::Type.newtype(:virt_pip) do
  desc "Puppet type for pip packages inside a virtualenv"
  ensurable

  newparam(:venv_path) do
    desc "Path to the virtualenv"
  end

  newparam(:pkg_name) do
    desc "Package name"
  end

  newparam(:name, :namevar => true) do
    desc "Path to the virtualenv and the name of the package separated by a colon"

    munge do |value|
      resource[:venv_path], resource[:pkg_name] = value.split(':')
    end
  end

  newproperty(:version) do
    desc "Version number to install/upgrade/downgrade"
  end

  newparam(:install_opts, :array_matching => :all) do
    desc "Flags passed to pip"
  end

end