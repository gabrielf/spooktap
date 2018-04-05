# Note: pull from git tag to get submodules
class Spook < Formula
  desc "Lightweight programmable evented utility based on LuaJIT and ljsyscall"
  homepage "https://github.com/johnae/spook"
  url "https://github.com/johnae/spook.git",
      :tag => "0.9.3",
      :revision => "c344112ed0f723f1834251dbbf36977d3fd128ea"
  head "https://github.com/johnae/spook.git"

  depends_on "cmake" => :build

  def install
    system "make", "PREFIX=#{prefix}", "CC=#{ENV.cc}"
    bin.install "spook"
  end

  def caveats
    <<~EOS
      To enable #{name} to watch more than 256 files you need to alter macOS's ulimits.

        echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>ProgramArguments</key>
    <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>524288</string>
      <string>524288</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>' | sudo tee /Library/LaunchDaemons/limit.maxfiles.plist
        echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>ProgramArguments</key>
    <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>524288</string>
      <string>524288</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>' | sudo tee /Library/LaunchDaemons/limit.maxproc.plist
        sudo chown root:wheel /Library/LaunchDaemons/limit.max{files,proc}.plist
        sudo launchctl load -w /Library/LaunchDaemons/limit.max{files,proc}.plist

      You have to restart macOS for the above changes to have any effect!

      For more details see: https://blog.dekstroza.io/ulimit-shenanigans-on-osx-el-capitan/
    EOS
  end

  test do
    system bin/"spook", "--version"
  end
end
