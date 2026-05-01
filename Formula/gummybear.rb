require "pathname"
require "fileutils"

class Gummybear < Formula
  desc "Gummybear is a command hosting service for ALL your commands."
  homepage "https://github.com/missingtrailingcomma/gummybear-client"
  url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.23/gummybear-client-source.tar.gz"
  sha256 "f9e0a423ad2337d76d37c06b6a55798ac4d8d2cbde1ad7520e71f61c94e34aee"

  depends_on "go" => :build

  # install func should strictly mimic Makefile install
  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  service do
    run [opt_bin/"gummybear-commander"]
    keep_alive true
    log_path var/"log/gummybear-commander.log"
    error_log_path var/"log/gummybear-commander-error.log"
  end

  def caveats
    <<~EOS
      To enable Gummybear's shell capture, add the following line to your shell rc file:

        eval "$(gummybear init zsh)"  # or bash

      You will also need to restart your terminal for this change to take effect.
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/gummybear --help")
    assert_match "Usage", shell_output("#{bin}/gummybear-commander --help")
  end
end
