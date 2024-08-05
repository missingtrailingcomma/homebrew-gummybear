class Gummybear < Formula
  desc "Gummybear is a command hosting "
  homepage "https://github.com/missingtrailingcomma/gummybear-client"
  url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.1/gummybear-client.tar.gz"
  sha256 "17cd0627165f8d373c483a03dc34e6a068fb364ff09e6f4e3023df52af1b9d6f"
  version "0.0.1"

  def install
    bin.install "gummybear-commander"
  end

  service do
    run [opt_bin/"gummybear-commander"]
    keep_alive true
    working_dir var
    log_path var/"log/gummybear-commander.log"
    error_log_path var/"log/gummybear-commander-error.log"
  end
end
