class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "d91499e5ed56905fd1d77a1bc691209ecda03c7241f76e72a1cfe73e739f3261"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 23
    sha256 cellar: :any, arm64_sequoia: "6a6abdb08075eafdea75e1c9ac2814fc231e4b25257d5bd3a94f25752c9313ef"
    sha256 cellar: :any, arm64_sonoma:  "5adc65caafc497e5da2432c5580beeb2ffb4b3484c61ebd7a69d8ad5d6dbcd8a"
    sha256 cellar: :any, x86_64_linux:  "14e9f2309e4f6620ee12c1e2aabdb603969bc4ec411f6ae02c1abf92e8651a1e"
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
