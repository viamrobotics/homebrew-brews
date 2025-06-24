class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.81.0.tar.gz"
  sha256 "c3e03cba7dea3fbf886ca9f9ed82da42d4689e71693314380d4599641b1e43a3"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bf8ac5a1d8a91f51d3a368e6d4f212dd359df9e366f5c8117176b828ec483011"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c4367d3efcf7aab8240ccf38edc72f07c10d2602959938b725642db7352deb6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1871c4ee3dad1e29f99c848f66ad898714ad0cc2d3ac382e003f3056b03f01d0"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
