class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.108.2.tar.gz"
  sha256 "8e3e4b26d40fa8ba9f593159be50b295a06f7a2d23c84cc11a8da3cb1c8abe84"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 51
    sha256 cellar: :any,                 arm64_sequoia: "26a9d4d05b1cb19ce322b18288d8a26fcfc12e5998aa5c8317880b167cc992e0"
    sha256 cellar: :any,                 arm64_sonoma:  "9a99d2ad176ee947792b404d0685a6668e550f8af6d643f7e02f28b028916c77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7e0855345dacb699b44e1db54acca21c3dad30ff3f93ccd4118f2c9b1552066"
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
