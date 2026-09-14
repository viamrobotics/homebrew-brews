class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "991098891766a71b593fa27da37a9239360c9deb1353b6e3b80a5fa6218f1325"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 25
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6ebee8d6f2007e7605a25191116137f1cc12bae07feda6f50427a2e72018a2cb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0e525b61d3110afa3b16b71f2803596905fde99f31eb10bf7d26c2d395fc35af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64439822b2a26b005fd5dd501812ed7fa91cadb3dc0042978a2ab2132a50d67e"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
