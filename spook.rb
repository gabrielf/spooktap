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

  test do
    system bin/"spook", "--version"
  end
end