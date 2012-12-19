Puppet::Type.type(:virt_pip).provide(:pip) do
  def create

    command = [File.join(resource[:venv_path], 'bin/pip'), 'install', '-U'] + [resource[:install_opts]]

    if resource[:version]
      command += [resource[:pkg_name] + '==' + resource[:version]]
    else
      command += [resource[:pkg_name]]
    end

    execute command

  end

  def destroy
    execute([File.join(resource[:venv_path], 'bin/pip'), 'uninstall', '--yes', resource[:pkg_name]])
  end

  def exists?
    begin
      output = execute([File.join(resource[:venv_path], 'bin/pip'), 'freeze']).split("\n")
      @pkg_version = Hash[*output.collect{ |item| x, y = item.split('==')
      [x, y] }.flatten]
      @pkg_version.keys.include? resource[:pkg_name]
    end
  end

  def version
    @pkg_version[resource[:pkg_name]]
  end

  def version=(ver)
    create    
  end

end
