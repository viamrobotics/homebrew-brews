class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.104.0.tar.gz"
  sha256 "81019c540b74c39e70622bfc5bf2d4637600c8ef61d3a8deca737c66f408a1ee"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 44
    sha256 cellar: :any,                 arm64_sequoia: "2ddbcdfaa8731691c8ba3f8dbf073981b92be99bdbf87c394a46e8a70377ec68"
    sha256 cellar: :any,                 arm64_sonoma:  "0f0473240d33806fd1b15ab8099f09005d2bad2b2f6ee240ba9fc43e6af5122d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b9ebd908bf2981722431e522c1d534c6c02328a58591115728dcb6547a07d0a"
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
