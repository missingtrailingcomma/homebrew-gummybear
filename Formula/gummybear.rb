class Gummybear < Formula
  desc "Gummybear is a command hosting service for ALL your commands."
  homepage "https://github.com/missingtrailingcomma/gummybear-client"
  url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.15/gummybear-client.tar.gz"
  sha256 "90dc7c9e68ed6b1fc0851399601755d48f17ea987fbf140d447b87be818924fe"

  def install
    # install the binary
    bin.install "gummybear"

    # install the launch agent
    bin.install "gummybear-commander"

    files = [
      "gummybear.sh",
      "util.sh",
      "dependencies/bash-preexec/bash-preexec.sh",
    ]

    # Copy files and preserve directory structure
    files.each do |file|
      # Construct the destination path
      dest_path = libexec/file

      # Create the destination directory if it does not exist
      mkdir_p File.dirname(dest_path)

      # Copy the file to the destination
      cp file, dest_path

      # Make the file executable
      chmod "+x", dest_path
    end

    mkdir_p etc/"gummybear/log"

    mkdir_p etc/"gummybear/config"
    cp "config/config.textproto", etc/"gummybear/config"

    setup_script = "setup.sh"
    setup_script_path = libexec/setup_script
    cp setup_script, setup_script_path
    chmod "+x", setup_script_path
  end

  service do
    run [opt_bin/"gummybear-commander", "--homebrew_base_dir=#{HOMEBREW_PREFIX}"]
    keep_alive true
    working_dir var
    log_path var/"gummybear/log/gummybear-commander.log"
    error_log_path var/"gummybear/log/gummybear-commander-error.log"
  end

  def caveats
    <<~EOS

      🚨 Run the following command to install the shell script to your shell rc file:
      🚨 #{libexec/"setup.sh"} #{libexec/"gummybear.sh"}
    EOS
  end
end
