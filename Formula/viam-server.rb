class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.106.0.tar.gz"
  sha256 "f58ea02d3b6a67d90ba3a44d01d26541fae145635739a1267b4662642eb75433"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 45
    sha256 cellar: :any,                 arm64_sequoia: "b6a42ea663f5d1181403bab335b5c6681a1b589c8bfa463cc428e270c9715196"
    sha256 cellar: :any,                 arm64_sonoma:  "d1c8add6cf008ea0630550dcb75201ad1a781bcd2bc98d809a6e7cf7b29e1fb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e64fdc57fb7f1a08eeddbf4fb59516ab14b66056f915e7f83b2af2db6bf0866"
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
