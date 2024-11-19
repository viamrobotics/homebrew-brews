class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.51.0.tar.gz"
  sha256 "04cc476e58195eb6dc61a43d6c3a20757fc3f1e5beb1196b8e8d8101c646d76c"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "140334cd202a15da009ad3493cf9a46d51bf98ad48dd9f27a5a5f98dc6ae262a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dda89ee677ee6b43d9a8b09d23b3021e9c6244a7442d97e3ffb6f946a9574f64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b11c124c1683d39112b1d8986e38c88e1181b5c7e04b66f3071081f00cbe305"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
