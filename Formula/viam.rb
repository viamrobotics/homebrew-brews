class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.108.0.tar.gz"
  sha256 "a000f1dd09a3f3d83749e24ed4ba4452d73f38046f37b32be58033c54e9665b5"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 49
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9d4389aaac7db010dcfcbf41dff8d793164124c3fe92b2b014f02ccecfc30a2b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cfa6aea87af5d9e59ea1c3d1e825b9ffcfcb3b8197a2c27204200517dd9da511"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30ae712ae6580ae2677bac76c1812827c7fb5f952cb79702444bccec5e68c4d4"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
