class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.119.1.tar.gz"
  sha256 "119d87ae882d98a6bb8d6d2cca44ff265810974b3090b013a45b06270315a201"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 63
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1e1ce59cc8b9aa3b262c62e8cffb446298887882358bcc661e33f3711bf2e864"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "172c805b062e3d69673a2b642e29da463cc175558c4cad781b33c9a63cdfc162"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9652c6208aa565ce65c12870cee033f07dc25098fa7880391144d55e2a5d2780"
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
