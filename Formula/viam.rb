class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.87.0.tar.gz"
  sha256 "46b4765eeef92474cf1dc2488da89ba98629b96e41a0133808d8a72c9abab5c7"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 19
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0678f58cb3f919eb63ea377af11f37844fdd7324a6fe919b07deed2dcdf8ae57"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ab99c3a932dca9fd52305252fa45d30088d0165d61d5738a91dadb6037987b05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ffab48c9149e23a74cc0e71c6b6db8ec370572c18c527dc8633805b665b857d"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
