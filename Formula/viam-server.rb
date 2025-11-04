class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.100.0.tar.gz"
  sha256 "9e215f3f1746ea00c4f9716c1aa8d17e8f56456af6788189c03ce2aaec89df0c"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 38
    sha256 cellar: :any,                 arm64_sequoia: "1371e4426b35260bb65ce96359035cc7a01ed34030ed02747953564f98a3bf33"
    sha256 cellar: :any,                 arm64_sonoma:  "84f52491df20b8a3e5681ee4256212b7ecf9cb13f7deea12b4b4675b1be96534"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "270ac36840180a77f7a7cd72876792d1acff8aa959385f71106d6eb490fb1433"
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
      Note that when installed via homebrew, the default location for the viam-server config is
      #{HOMEBREW_PREFIX}/etc/viam.json
    EOS
  end

  test do
    assert_match "Viam RDK", shell_output("#{bin}/viam-server --version 2>&1")
  end
end
