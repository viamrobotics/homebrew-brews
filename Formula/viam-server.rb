class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.114.0.tar.gz"
  sha256 "6970fb88f74f2b367cad325b48da883d1a0b2d9b56af38a558df975ddb7aafd8"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 58
    sha256 cellar: :any,                 arm64_sequoia: "c39817fe5e10f763628ab4577c1db68506210f929c61a6d8110e4e135423f976"
    sha256 cellar: :any,                 arm64_sonoma:  "0e4f5a170e39bfde809eac57dfa0f12f7e7c0727ae4df311c9ac56d51d11c276"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "960e14702cb2abc2bf012d4368a0b77a6e9832b59d2caf076f7085cc8e5d041f"
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

    os = OS.linux? ? "Linux" : "Darwin"
    arch = if Hardware::CPU.intel?
      "x86_64"
    elsif Hardware::CPU.arm?
      OS.linux? ? "aarch64" : "arm64"
    end

    bin.install "bin/#{os}-#{arch}/viam-server"
    etc.install "etc/configs/fake.json" => "viam.json"
  end

  def caveats
    <<~EOS
      Optionally, viam-server can be run as a background service.

      To run as a service, place your machine configuration from https://app.viam.com at:
        #{HOMEBREW_PREFIX}/etc/viam.json

      Then start the service with:
        brew services start viam-server

      For more information about services, run:
        brew services --help
    EOS
  end

  test do
    assert_match "Viam RDK", shell_output("#{bin}/viam-server --version 2>&1")
  end

  service do
    run [opt_bin/"viam-server", "-config", etc/"viam.json"]
    keep_alive true
    log_path var/"log/viam-server.log"
    error_log_path var/"log/viam-server.log"
  end
end
