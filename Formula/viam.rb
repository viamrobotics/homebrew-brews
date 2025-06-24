class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.81.0.tar.gz"
  sha256 "c3e03cba7dea3fbf886ca9f9ed82da42d4689e71693314380d4599641b1e43a3"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 10
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6501383d6e8c8e16ccd967ec3ce6454991ec07e5b48563b4944d6c6902ef00a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "02eed2860155b361ba9b8e5198ac17c30434d0d30f30c20c489055977c80f41e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86767f9a4df70aa457501e926fd4fcccbab1bf335c3907149ea4ab9c1197e454"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
