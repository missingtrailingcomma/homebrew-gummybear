class GummybearDev < Formula
  desc "Gummybear saves your shell commands (DEV)"
  homepage "https://github.com/missingtrailingcomma/gummybear"
  url "file:///tmp/gummybear/gummybear-client-source.tar.gz"
  version "0.0.1"

  depends_on "go" => :build

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
