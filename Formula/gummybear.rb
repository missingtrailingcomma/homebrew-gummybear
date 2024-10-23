class Gummybear < Formula
    desc "Gummybear is a command hosting service for ALL your commands."
    homepage "https://github.com/missingtrailingcomma/gummybear-client"
    url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.19/gummybear-client-source.tar.gz"
    sha256 "1e8d5455671f96ee1e915a91c7ae8fcb6f50469d40c780aab7b3312e5da000b8"
  
    depends_on "go" => :build
  
    # install func should strictly mimic Makefile install
    def install
      system "make", "init_conf_and_log_dir"
   
      system "make", "binaries"
  
      bin.install "/tmp/gummybear/gummybear"
      bin.install "/tmp/gummybear/gummybear-commander"
  
      (prefix/"share/shell-hook").mkpath
      (prefix/"share/shell-hook").install "cli/shell-hook.sh"
      (prefix/"share/shell-hook/dependencies/bash-preexec").mkpath
      (prefix/"share/shell-hook/dependencies/bash-preexec").install "cli/dependencies/bash-preexec/bash-preexec.sh"
    end
  
    service do
      run [opt_bin/"gummybear-commander"]
      keep_alive true
      working_dir ENV["HOME"] + "/.local/share/gummybear"
      log_path ENV["HOME"] + "/.local/share/gummybear/logs/gummybear-commander.log"
      error_log_path ENV["HOME"] + "/.local/share/gummybear/logs/gummybear-commander-error.log"
    end
  
    def caveats
      <<~EOS
        To complete installation , add the following line to your shell rc file:
  
          source #{prefix/"share/shell-hook/shell-hook.sh"}
  
        You will also need to restart your terminal for this change to take effect.
      EOS
    end
  
    test do
      assert_predicate libexec/"gummybear-shell-hook.sh", :exist?, "Shell hook script not installed"
      assert_predicate libexec/"dependencies/bash-preexec/bash-preexec.sh", :exist?, "Shell hook script not installed"
    end
  end
  