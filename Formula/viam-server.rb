class ViamServer < Formula
  desc "The main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "1a83c716f4a9e120e76c2b076854c29556697d5dd80457e15f603db4a4466f3b"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build
  depends_on "nlopt"
  depends_on "x264"
  depends_on "opus"
  depends_on "tensorflowlite" 
  depends_on "ffmpeg"

  def install
    system "make", "server"
    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "bin/Linux-x86_64/server" => "viam-server"
      elsif Hardware::CPU.arm?
        bin.install "bin/Linux-aarch64/server" => "viam-server"
      end
    elsif OS.mac?
      if Hardware::CPU.intel?
        bin.install "bin/Darwin-x86_64/server" => "viam-server"
      elsif Hardware::CPU.arm?
        bin.install "bin/Darwin-arm64/server" => "viam-server"
      end
    end
    etc.install "etc/configs/fake.json" => "viam.json"
  end

  service do
    run [bin/"viam-server", "-config", etc/"viam.json"]
  end

  def caveats
    <<~EOS
      Note that when installed via homebrew, the default location for the viam-server config is
      #{HOMEBREW_PREFIX}/etc/viam.json

      To manage viam-server as a service, use brew's service command. Run the following for more info:
      # brew services --help
    EOS
  end
end
