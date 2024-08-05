class Gummybear < Formula
  desc "Gummybear is a command hosting "
  homepage "https://github.com/missingtrailingcomma/gummybear-client"
  url "https://github.com/missingtrailingcomma/gummybear-client/releases/download/v0.0.1/gummybear-client.tar.gz"
  sha256 "17cd0627165f8d373c483a03dc34e6a068fb364ff09e6f4e3023df52af1b9d6f"
  version "0.0.1"

  def install
    bin.install "gummybear-commander"
  end

  plist_options startup: true

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.r-kyve.gummybear-commander</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/gummybear-commander</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
      </plist>
    EOS
  end
end
