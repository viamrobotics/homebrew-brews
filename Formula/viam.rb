class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.47.0.tar.gz"
  sha256 "aaba76181c64f7c7ffac73a41ab654b67ca15358aed10fc753a294c6d463cbb7"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e02baaca1ae314529251d8c360a2a659fc05896ce1fb69dee47ec88da2f3ee82"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
