class Gummybear < Formula
  desc "Gummybear is a command hosting service for ALL your commands."
  homepage "https://github.com/missingtrailingcomma/gummybear-client"
  url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.16/gummybear-client.tar.gz"
  sha256 "46ac059fa48e0cb16131b6b5a96eac6b95bd12abd79a12d4f0a8158ce33b8571"

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
      To complete installation, add the following line to your shell rc file:

        source #{libexec/"gummybear.sh"}

      You will also need to restart your terminal for this change to take effect.
    EOS
  end
end
