require "pathname"
require "fileutils"

class Gummybear < Formula
  desc "Gummybear is a command hosting service for ALL your commands."
  homepage "https://github.com/missingtrailingcomma/gummybear-client"
  url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.24/gummybear-client-source.tar.gz"
  sha256 "505b6a6502e48b04289aa0e8a48df69f2897d0d175cabe1b3f6ee62f7e6e3167"

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
