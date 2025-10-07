class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.96.0.tar.gz"
  sha256 "6062309da562761c6f3fd1966cf68c5d5ebb0aac10282193a06317368dcf39b5"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 33
    sha256 cellar: :any,                 arm64_sequoia: "255b14e88f57658dec9c60d09b7f9141a78fa304d34f560867c6e36e8e6f0f3b"
    sha256 cellar: :any,                 arm64_sonoma:  "0002682941b6f9463901396f92194fbc37ed98fe28b89ae39f799640e4866b22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64a4a3dcbc387e1c0565bf6fdbf713ee23496386378e6e7dd623846a2fb1b482"
  end

  depends_on "go" => :build
  depends_on "node@20" => :build
  depends_on "pkg-config" => :build
  depends_on "nlopt-static"
  depends_on "ffmpeg"
  depends_on "jpeg-turbo"
  depends_on "opus"
  depends_on "x264"

  def install
    with_env(
      "TAG_VERSION" => "v#{version}",
    ) do
      system "make", "server"
    end
    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "bin/Linux-x86_64/viam-server" => "viam-server"
      elsif Hardware::CPU.arm?
        bin.install "bin/Linux-aarch64/viam-server" => "viam-server"
      end
    elsif OS.mac?
      if Hardware::CPU.intel?
        bin.install "bin/Darwin-x86_64/viam-server" => "viam-server"
      elsif Hardware::CPU.arm?
        bin.install "bin/Darwin-arm64/viam-server" => "viam-server"
      end
    end
    etc.install "etc/configs/fake.json" => "viam.json"
  end

  def caveats
    <<~EOS
      Note that when installed via homebrew, the default location for the viam-server config is
      #{HOMEBREW_PREFIX}/etc/viam.json
    EOS
  end
end
