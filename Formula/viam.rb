class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.92.0.tar.gz"
  sha256 "468189bd8788b99e8d856624ffebdb0ca3a74039aff4e04ef3d4c04655fe6306"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 27
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "551c0996932e3d16d230899a50c6b9255833a254755c1c97e1cc62f8f3c49653"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ae41944f89033b80c2fb724650d23044f53d20216a793dae7233551c6f1745c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "515ba4e549d7f60f823adf2100cecd5a3df221ab8fea2c31aa915128d3f9051b"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
